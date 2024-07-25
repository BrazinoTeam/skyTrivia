//
//  InfoHomeVC.swift


import Foundation
import UIKit

class InfoHomeVC: UIViewController {
    
    var selectCount: Int = 0 {
        didSet {
        updateInfo()
        }
    }
    
    
    private var contentView: InfoHomeView {
        view as? InfoHomeView ?? InfoHomeView()
    }
    
    override func loadView() {
        view = InfoHomeView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectBtn()
    }
    
    private func selectBtn() {
        contentView.backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        contentView.quizBtn.addTarget(self, action: #selector(quizViewTapped), for: .touchUpInside)

    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func quizViewTapped() {
       
        let quizVC = InfoQuizVC(selectedAirplaneIndex: selectCount)
        navigationController?.pushViewController(quizVC, animated: false)
    }
    
    private let imageCell: [UIImage] = [.imgLockheedVega, .imgBeechcraftModel18, .imgPiperPA, .imgCessna310, .imgBeechcraftBaron, .imgCessna402, .imgBeechcraftKingAir]

    private func updateInfo() {
        switch selectCount {
        case 0:
            contentView.titleLabel.text = "Lockheed Vega"
            contentView.centerImage.image = .imgLockheedVega
            contentView.bodyFieldInfo.text  = "    The Lockheed Vega is an iconic aircraft that played a significant role in the history of aviation. First designed by Lockheed in 1927, the Vega was intended as a high-performance, long-range aircraft. Its design featured a cantilever wing, which eliminated the need for struts, contributing to its sleek, aerodynamic shape. The aircraft was built with a wooden fuselage covered in plywood, which provided strength while keeping the weight down. The Vega could carry up to six passengers and was initially powered by a 450-horsepower Pratt & Whitney Wasp radial engine, giving it a maximum speed of approximately 135 miles per hour and a range of around 700 miles. \nThe Vega gained fame for its involvement in several notable flights and records. One of the most famous Vegans, the Winnie Mae, was flown by Wiley Post, who set a record for flying around the world solo in 1933. The aircraft also played a crucial role in Amelia Earhart's historic transatlantic solo flight in 1932, making her the first woman to achieve this feat. These record-breaking flights showcased the Vega's reliability, endurance, and advanced design for its time.\nBesides its record-breaking flights, the Vega was used in various roles, including mail delivery, exploration, and air racing. It was renowned for its ruggedness and ability to operate in harsh conditions, which made it a favorite among pilots who required a dependable and versatile aircraft. The Vega's design and performance left a lasting legacy in aviation history, influencing subsequent aircraft designs and cementing its place as a pioneering model in the evolution of aviation."
        case 1:
            contentView.titleLabel.text = "Beechcraft Model 18"
            contentView.centerImage.image = .imgBeechcraftModel18
            contentView.bodyFieldInfo.text  = "    The Beechcraft Model 18, also known as the Twin Beech, is a twin-engine, low-wing aircraft that was first produced by Beech Aircraft Corporation in 1937. It became one of the most versatile and widely used aircraft in history, with over 9,000 units produced during its long production run, which lasted until 1970. The Model 18 was designed as a light transport aircraft and was widely used for both civilian and military purposes.\nThe aircraft was powered by two Pratt & Whitney R-985 radial engines, each producing 450 horsepower, giving it a maximum speed of around 230 miles per hour and a range of approximately 1,200 miles. Its all-metal construction and retractable landing gear were advanced features for its time, contributing to its durability and performance. The Model 18 could carry up to 11 passengers or 2,500 pounds of cargo, making it suitable for a variety of roles, including passenger transport, cargo hauling, and executive travel.\nDuring World War II, the Model 18 was adapted for military use under various designations, such as the C-45 Expeditor, AT-7 Navigator, and AT-11 Kansan. It was used for training, transport, and reconnaissance missions. The aircraft's reliability and ease of maintenance made it a valuable asset to the military. After the war, many surplus Model 18s were converted for civilian use, further cementing its legacy as a workhorse of the skies.\nThe Beechcraft Model 18's versatility extended to special missions, including aerial spraying, air ambulance, and skydiving operations. Its rugged design allowed it to operate from unimproved airstrips, adding to its appeal in remote and challenging environments. The Model 18's longevity and widespread use are testaments to its exceptional design and performance, making it a classic in the annals of aviation history."
        case 2:
            contentView.titleLabel.text = "Piper PA-23 Apache"
            contentView.centerImage.image = .imgPiperPA
            contentView.bodyFieldInfo.text  = "The Piper PA-23 Apache, initially developed in the early 1950s, is a light twin-engine aircraft that marked Piper Aircraft's entry into the twin-engine market. The Apache was designed to be an affordable and versatile light twin for private and corporate use, as well as for flight training. It first flew in 1952 and quickly became popular due to its reliability and ease of handling. The PA-23 was originally powered by two Lycoming O-320 engines, each producing 150 horsepower, but later models featured more powerful engines.\nThe Apache's design includes a low-wing, all-metal construction with retractable landing gear and a conventional tail configuration. The aircraft typically seats four to six people, including the pilot, and features a spacious cabin for its size. Its maximum speed is around 190 miles per hour, and it has a range of approximately 700 miles, making it suitable for short to medium-haul flights.\nOne of the Apache's significant contributions was its role in training new pilots. Its forgiving flight characteristics and reliable performance made it an excellent platform for multi-engine flight training. Many pilots earned their multi-engine ratings in Apaches, which contributed to the model's widespread use in flight schools around the world.\nOver its production run, the Apache saw several upgrades and variants, including the more powerful and larger PA-23 Aztec. These improvements included enhanced avionics, increased payload capacity, and better overall performance. Despite these advancements, the Apache maintained its reputation for being a dependable and straightforward aircraft, ideal for private owners and flight training institutions.\nThe Apache's legacy in aviation is marked by its contribution to making twin-engine flying more accessible and its role in training countless pilots. Its combination of performance, reliability, and affordability has ensured its place as a beloved aircraft among pilots and aviation enthusiasts."
            
        case 3:
            contentView.titleLabel.text = "Cessna 310"
            contentView.centerImage.image = .imgCessna310
            contentView.bodyFieldInfo.text  = "The Cessna 310 is a twin-engine, low-wing aircraft that became one of Cessna's most successful models. First introduced in 1954, the 310 was designed to provide superior performance, comfort, and reliability. Its initial version was powered by two Continental O-470-B engines, each producing 240 horsepower, giving the aircraft a maximum speed of around 220 miles per hour and a range of approximately 1,000 miles.\nThe Cessna 310 featured several innovations, including a swept tail design and tip tanks, which not only provided additional fuel capacity but also improved aerodynamic stability. The aircraft's all-metal construction, retractable landing gear, and pressurized cabin (in later models) were advanced features that contributed to its popularity among private owners, charter operators, and corporate flight departments.\nThe 310 could comfortably seat up to six people, including the pilot, and offered a spacious cabin with large windows, providing excellent visibility and comfort for passengers. Its performance capabilities, such as the ability to operate from short and unimproved airstrips, made it versatile for various missions, including passenger transport, cargo hauling, and medical evacuation.\nThe Cessna 310 also saw extensive use in military applications under various designations, such as the U-3 Blue Canoe, used primarily for liaison and utility roles. Its reputation for reliability and ease of maintenance made it a preferred choice for many operators worldwide.\nThroughout its production run, which lasted until 1980, the Cessna 310 underwent numerous upgrades and improvements, including more powerful engines, enhanced avionics, and increased fuel capacity. These refinements ensured that the 310 remained competitive in the light twin-engine market and continued to be a popular choice for a wide range of aviation needs."

        case 4:
            contentView.titleLabel.text = "Beechcraft Baron"
            contentView.centerImage.image = .imgBeechcraftBaron
            contentView.bodyFieldInfo.text  = "The Beechcraft Baron is a twin-engine, light aircraft known for its performance, luxury, and reliability. First introduced in 1961 by Beechcraft, a subsidiary of Textron Aviation, the Baron has become one of the most popular and enduring light twins in aviation history. The initial models, designated as the Baron 55, were powered by two Continental IO-470-L engines, each producing 260 horsepower, giving the aircraft a maximum speed of approximately 200 miles per hour and a range of around 1,200 miles.\nThe Baron features an all-metal construction with a low-wing configuration, retractable landing gear, and a distinctive T-tail design. The cabin can typically accommodate six passengers, including the pilot, and offers a high level of comfort and luxury, making it popular for business and personal travel. The aircraft's advanced avionics, including autopilot and modern navigation systems, further enhance its appeal to pilots and passengers alike.\nOne of the key aspects of the Baron's success is its versatility. It can operate from short and unimproved airstrips, making it suitable for a variety of missions, including executive transport, air taxi services, and medical evacuation. The Baron's robust design and powerful engines also provide excellent performance in terms of climb rate, speed, and payload capacity.\nOver the years, the Baron has seen several variants, including the more powerful Baron 58, which features larger engines and a longer fuselage. These upgrades have ensured that the Baron remains competitive and relevant in the modern aviation market. Its reputation for reliability and ease of maintenance has made it a favorite among pilots and operators worldwide.\nThe Beechcraft Baron's legacy is marked by its combination of performance, luxury, and versatility. It continues to be a symbol of quality and excellence in general aviation, with a loyal following among aviators and aviation enthusiasts."

        case 5:
            contentView.titleLabel.text = "Cessna 402"
            contentView.centerImage.image = .imgCessna402
            contentView.bodyFieldInfo.text  = "The Cessna 402 is a twin-engine, piston-powered light aircraft that was developed by Cessna for commercial and utility operations. First flown in 1965, the Cessna 402 was designed to be a workhorse for short-haul flights, offering excellent performance, reliability, and cost-effectiveness. The aircraft was powered by two Continental TSIO-520-VB engines, each producing 325 horsepower, allowing for a maximum speed of around 230 miles per hour and a range of approximately 1,200 miles.\nThe 402 features a low-wing, all-metal construction with retractable landing gear and a conventional tail design. It typically seats up to ten passengers, including the pilot, and provides a spacious and comfortable cabin for its size. The aircraft's design emphasizes ease of maintenance and operation, making it a popular choice for regional airlines, air taxi services, and cargo operators.\nOne of the distinguishing features of the Cessna 402 is its capability to operate from short and unimproved airstrips, which enhances its versatility in various operational environments. The aircraft's robust design and powerful engines provide excellent performance, including a high climb rate and good fuel efficiency, which are crucial for commercial operations.\nThe Cessna 402 has seen several variants, including the 402A and 402B, which incorporated various improvements in avionics, payload capacity, and overall performance. These upgrades ensured that the 402 remained competitive in the light twin-engine market and continued to meet the evolving needs of commercial operators.\nThroughout its production run, which lasted until 1985, the Cessna 402 became known for its dependability and cost-effective operation. Its versatility and performance made it a preferred choice for many regional airlines and charter operators, solidifying its reputation as a reliable and efficient aircraft in the aviation industry."

        case 6:
            contentView.titleLabel.text = "Beechcraft King Air"
            contentView.centerImage.image = .imgBeechcraftKingAir
            contentView.bodyFieldInfo.text  = "The Beechcraft King Air is a family of twin-turboprop aircraft produced by Beechcraft, a subsidiary of Textron Aviation. First introduced in 1964, the King Air series has become one of the most successful and widely used turboprop aircraft in the world. The King Air was designed to provide a reliable, versatile, and comfortable platform for business and utility operations. It features a pressurized cabin, allowing for high-altitude flight and enhanced passenger comfort.\nThe initial models of the King Air were powered by two Pratt & Whitney PT6A-20 turboprop engines, each producing 550 horsepower. The aircraft has a maximum speed of approximately 270 miles per hour and a range of around 1,500 miles, making it suitable for a variety of missions, including executive transport, air ambulance, and cargo hauling. The King Air's all-metal construction, retractable landing gear, and advanced avionics contribute to its reputation for reliability and performance.\nThe King Air series includes several variants, such as the King Air 90, King Air 100, and the larger King Air 200 and 300 series. Each variant offers improvements in performance, range, and passenger capacity. The King Air 200 and 300 series, in particular, are known for their extended range, increased payload capacity, and advanced avionics systems.\nOne of the key aspects of the King Air's success is its versatility. The aircraft can operate from short and unimproved airstrips, making it suitable for use in remote and challenging environments. Its ability to carry a combination of passengers and cargo, along with its reliable performance, has made it a popular choice for both civilian and military operators worldwide.\nThe Beechcraft King Air's legacy is marked by its widespread use and enduring popularity. It continues to be a symbol of quality and excellence in the turboprop market, with a loyal following among pilots and aviation enthusiasts."
        default:
            break

        }
//        contentView.updateGradient()

    }
}
