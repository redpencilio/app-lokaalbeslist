export default [
  {
    match: {},
    callback: {
      url: "http://subscription/.mu/delta", method: "POST"
    },
    options: {
      resourceFormat: "v0.0.1",
      gracePeriod: 1000,
      ignoreFromSelf: false
    }
  }
]
