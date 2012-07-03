
class BackpackingController < ApplicationController

  # probably better to store this as metadata on the image
  # iterating over parallel arrays never makes me feel good
  @@captions =
    [
     "A few miles north of the border",
     "Anza-Borrego desert crossing",
     "Grassland South of Warner Springs",
     "Ice Storm in the San Jacinto Range",
     "Oaks in the Sierra Pelona",
     "Entering the High Sierra",
     "Whitney Ascent",
     "Still Climbing Whitney",
     "Approach to Forrester Pass",
     "Mather Pass",
     "Winter Wonderland near Muir Pass",
     "Evening Ascent of Donahue Pass",
     "High Ridgeline South of Sonoroa Pass",
     "Hat Creek Rim",
     "Mt Shasta",
     "Trinity Alps",
     "Looking South near CA/OR border",
     "Evening near Ashland",
     "Crater Lake",
     "Crater Lake Morning",
     "Oregon Morning",
     "South Sister",
     "Mordor",
     "North towards Mt. Hood",
     "Companionship",
     "Comic Sans",
     "Goat Rocks Wilderness",
     "On Top of Old Snowy",
     "Mt. Ranier",
     "The Rising Tide of Bad Weather",
     "Rain in the Alpine Lakes Wilderness",
     "Clear Morning",
     "North Cascades",
     "The Final Challenge",
     "Clear Weather on Final Morning",
     "Unbelieveable Beauty",
     "Snow Frosting",
     "All done!",
    ]

  def index
    @files = []
    idx = 0
    Dir.glob("app/assets/images/scaled/*.jpg").sort.each do |filename|
      image = {}
      basename = File.basename(filename)
      image[:name] = basename
      image[:path] = "assets/scaled/" + basename
      image[:thumb] = "assets/scaled/thumbs/" + basename
      image[:caption] = @@captions[idx]
      @files.push(image)
      idx += 1
    end
 
  end

end
