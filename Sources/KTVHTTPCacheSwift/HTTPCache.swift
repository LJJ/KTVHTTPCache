import Foundation
@_implementationOnly import KTVHTTPCache

public enum HTTPCache {
    // MARK: - Server

    public static func start() throws {
        try KTVHTTPCache.proxyStart()
    }

    public static func stop() {
        KTVHTTPCache.proxyStop()
    }

    public static func setPort(_ port: UInt16) {
        KTVHTTPCache.proxySetPort(port)
    }

    public static var isRunning: Bool { KTVHTTPCache.proxyIsRunning() }

    public static func isProxyURL(_ url: URL) -> Bool {
        KTVHTTPCache.proxyIsProxyURL(url)
    }

    public static func proxyURL(for url: URL, bindToLocalhost: Bool = true) -> URL {
        if bindToLocalhost { return KTVHTTPCache.proxyURL(withOriginalURL: url) }
        return KTVHTTPCache.proxyURL(withOriginalURL: url, bindToLocalhost: false)
    }

    public static func originalURL(from url: URL) -> URL {
        KTVHTTPCache.proxyOriginalURL(with: url)
    }

    // MARK: - Cache

    public static func completeFileURL(for url: URL) -> URL? {
        KTVHTTPCache.cacheCompleteFileURL(with: url)
    }

    public static var maxCacheLength: Int64 {
        get { KTVHTTPCache.cacheMaxCacheLength() }
        set { KTVHTTPCache.cacheSetMaxCacheLength(newValue) }
    }

    public static var totalCacheLength: Int64 { KTVHTTPCache.cacheTotalCacheLength() }

    public static func deleteCache(for url: URL) { KTVHTTPCache.cacheDelete(with: url) }
    public static func deleteAllCaches() { KTVHTTPCache.cacheDeleteAllCaches() }

    // MARK: - URL Mapping / Encode

    public static func setURLConverter(_ block: @escaping (URL) -> URL) {
        KTVHTTPCache.encodeSetURLConverter { input in
            guard let input = input else { return nil }
            return block(input)
        }
    }

    // MARK: - HLS

    public static func setHLSContentHandler(_ block: @escaping (String) -> String) {
        KTVHTTPCache.hlsSetContentHandler { content in
            guard let content = content else { return nil }
            return block(content)
        }
    }

    // MARK: - Download Config (core)

    public static var timeoutInterval: TimeInterval {
        get { KTVHTTPCache.downloadTimeoutInterval() }
        set { KTVHTTPCache.downloadSetTimeoutInterval(newValue) }
    }

    public static var whitelistHeaderKeys: [String] {
        get { KTVHTTPCache.downloadWhitelistHeaderKeys() ?? [] }
        set { KTVHTTPCache.downloadSetWhitelistHeaderKeys(newValue) }
    }

    public static var additionalHeaders: [String: String] {
        get { KTVHTTPCache.downloadAdditionalHeaders() ?? [:] }
        set { KTVHTTPCache.downloadSetAdditionalHeaders(newValue) }
    }

    // You can extend acceptableContentTypes / unacceptableContentTypeDisposer here if needed.

    // MARK: - Log (optional)
    // Expose logging convenience if required later.
}
