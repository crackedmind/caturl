
import React from 'react'
import CopyToClipboard from 'react-copy-to-clipboard'
import { Alert, Tooltip } from 'reactstrap'

function get_csrf_token() {
  let meta = Array.from(document.getElementsByTagName('meta'))
  return meta.find(i => i.name === 'csrf-token').content
}

class Results extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      copied: false
    }
  }
  copy() {
    this.setState({copied: true})
    setTimeout(() => {
      this.setState({copied: false})
    }, 1000)
  }

  render() {
    return <div className="row justify-content-center" >
      <div className="card results">
        <div className="card-body">
          <h4 className="card-title"><a href={this.props.url}>{this.props.url}</a></h4>
          <span className="card-text"><a href={this.props.short_url}>{this.props.short_url}</a></span>
          
          <CopyToClipboard text={this.props.short_url} onCopy={this.copy.bind(this)}>
            <a id="short" href="#" className="btn btn-sm btn-outline-warning">Copy</a>
          </CopyToClipboard>
          <Tooltip isOpen={this.state.copied} target="short">
            Copied!  
          </Tooltip>
          
        </div>
      </div>
    </div>
  }
}

export default class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show_result: false,
      results: null,
      url: null,
      errors: null,
      errors_visible: false
    }
  }
  submit(e) {
    get_csrf_token()
    e.preventDefault()
    fetch('/', {
      credentials: 'include',
      method: 'post',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': get_csrf_token()
      },
      body: JSON.stringify({
        url: this.state.url
      })
    }).then(res => {
      if(res.status === 201) {
        res.json().then((data) => {
          this.setState({results: data, show_result: true, errors: null})
        })
      } else if (res.status === 406) {
        res.json().then((data) => {
          this.setState({errors: data['error_messages'], errors_visible: true})
        })
      }
    })
    
  }

  onDismiss() {
    this.setState({errors_visible: false})
  }
  render() {
    return <div className="container">

      <Alert isOpen={this.state.errors_visible} toggle={this.onDismiss.bind(this)} color="danger">
        {
          this.state.errors ? this.state.errors.map((e) => {
            return <p>{e}</p>
          }) : ''
        }
      </Alert>
      <div className="row justify-content-center">

        <form>
          <div className="input-group">
            <input onChange={(e) => this.setState({url: e.target.value})}
              type="text" className="form-control form-control-lg" placeholder="Paste a link to shorten it" />
            <span className="input-group-btn">
              <button onClick={this.submit.bind(this)} className="btn btn-warning btn-lg shrt-btn">shorten</button>
            </span>
          </div>
        </form>
      </div>

      {this.state.show_result &&
        <Results {...this.state.results} />
      }
    </div >
  }
}
