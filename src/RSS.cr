require "xml"

class RSS

    @items = [] of Hash(String, String)

    def initialize(
            @title : String = "Untitled RSS Feed", 
            @description : String = "", 
            @generator : String = "RSS for Crystal",
            @site_url : String = "",
            #feed_url : String = "",
            @author : String = "",
            @pubDate : String = "",
            @copyright : String = "",
            @language : String = "",
            @managingEditor : String = "",
            @webMaster : String = "",
            @docs : String = "",
            @ttl : String = "",
            #hub : String = ""
        )
    end

    def item(
            title : String, 
            description : String = "", 
            link : String = "", 
            guid : String = "",
            author : String = "",
            pubDate : String = ""
        )
        item = {
            "title" => title,
            "description" => description,
            "link" => link,
            "guid" => guid,
            "author" => author,
            "pubDate" => pubDate
        }
        @items << item
    end
    
    def xml(indent : Bool = false)
        XML.build(encoding: "UTF-8", indent: indent ? "  " : "") do |xml|
            xml.element("rss", "xmlns:dc": "http://purl.org/dc/elements/1.1/", "xmlns:content": "http://purl.org/rss/1.0/modules/content/", "xmlns:atom": "http://www.w3.org/2005/Atom", version: "2.0") do
                xml.element("channel") do
                    xml.element("title") { xml.cdata @title }
                    xml.element("description") { xml.cdata @description.empty? ? @title : @description }
                    xml.element("link") { xml.text @site_url.empty? ? "https://github.com/ga2mer/rss.cr" : @site_url }
                    xml.element("generator") { xml.text @generator }
                    xml.element("lastBuildDate") { xml.text Time.utc_now.to_s }

                    #!@feed_url.empty? && xml.element("atom:link", "atom:link")
                    !@author.empty? && xml.element("author") { xml.cdata @author }
                    !@pubDate.empty? && xml.element("pubDate") { xml.text @pubDate }
                    !@copyright.empty? && xml.element("copyright") { xml.cdata @copyright }
                    !@language.empty? && xml.element("language") { xml.cdata @language }
                    !@managingEditor.empty? && xml.element("managingEditor") { xml.cdata @managingEditor }
                    !@webMaster.empty? && xml.element("webMaster") { xml.cdata @webMaster }
                    !@docs.empty? && xml.element("docs") { xml.text @docs }
                    !@ttl.empty? && xml.element("ttl") { xml.text @ttl }
                    @items.each do |item|
                        xml.element("item") do
                            xml.element("title") { xml.cdata item["title"] }
                            !item["description"].empty? && xml.element("link") { xml.cdata item["description"] }
                            !item["link"].empty? && xml.element("link") { xml.text item["link"] }
                            #worst
                            !item["link"].empty? || !item["guid"].empty? || !item["title"].empty? ? xml.element("guid", "isPermaLink": item["guid"].empty? || !item["link"].empty?) { 
                                if item["link"].empty?
                                    if item["guid"].empty?
                                        xml.text item["title"]
                                    else
                                        xml.text item["guid"]
                                    end
                                else
                                    xml.text item["link"]
                                end
                            } : false
                            !item["pubDate"].empty? && xml.element("pubDate") { xml.text item["pubDate"] }
                            !item["author"].empty? && xml.element("author") { xml.cdata item["author"] }
                        end
                    end
                end
            end
        end
    end
end