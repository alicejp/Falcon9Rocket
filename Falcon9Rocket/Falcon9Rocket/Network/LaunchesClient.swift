import Foundation

protocol LaunchesClientProtocol
{
    func getLaunches(completionHandler: @escaping (Result<[LaunchModelInfo]?, Error>) -> Void)
}

class LaunchesClient: LaunchesClientProtocol
{
    func getLaunches(completionHandler: @escaping (Result<[LaunchModelInfo]?, Error>) -> Void)
    {
        guard let url = URL(string: "https://api.spacexdata.com/v3/launches") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode([LaunchModelInfo].self, from: data)
                completionHandler(.success(launches))

            }catch let parseError {
                completionHandler(.failure(parseError))
            }
        }.resume()
    }
}

class LaunchesService
{
    var client: LaunchesClientProtocol!

    init(client: LaunchesClientProtocol)
    {
        self.client = client
    }

    func getLaunches(completionHandler: @escaping (Result<[LaunchModelInfo]?, Error>) -> Void)
    {
        return client.getLaunches(completionHandler: completionHandler)
    }
}
