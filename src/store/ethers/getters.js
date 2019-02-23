/* eslint-disable */
export default {
  userInfo: state => {
    return state.address.substr(0, 4)+'...'
  }
}
