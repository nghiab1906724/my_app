class DataRepository {
  Map<String, Map> getData(){
    try {
      return {
        'Luân': {
          '01-10-2023': {
            "0": {
              'com': 20000,
              'nuoc ngot': 10000,
              'banh': 5000,
            },
            "1": {
              'com': 50000,
            }
          }
        },
        'Bảo': {
          '01-10-2023': {
            "0": {
              'com': 20000,              
              'banh': 5000,
            },
            "1": {
              'com': 50000,
              'giặt sấy': 38000,
            }
          }
        }
      };
    } catch (e) {
      return {};
    }

    // print(content);
  }
}
