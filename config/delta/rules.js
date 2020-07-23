export default [
  {
    match: {
      subject: {},
    },
    callback: {
      url: 'http://resource/.mu/delta',
      method: 'POST',
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 250,
      ignoreFromSelf: true,
    },
  },
  {
    match: {},
    callback: {
      method: 'POST',
      url: 'http://search/update',
    },
    options: {
      resourceFormat: 'v0.0.1',
      gracePeriod: 1000,
      ignoreFromSelf: true,
    },
  },
];
