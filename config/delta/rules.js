export default [
  {
    match: {
      predicate: {
        type: 'uri',
        value: 'http://www.w3.org/ns/adms#status'
      },
      object: {
        type: 'uri',
        value: 'http://lblod.data.gift/concepts/d72999bf-2ef4-4332-bd6e-49c8a9e2498e'
      }
    },
    callback: {
      method: 'POST',
      url: 'http://search/update',
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 1000,
      ignoreFromSelf: true
    }
  }
]