class CvPdf < Prawn::Document

  def initialize(user)
    super()
    @user = user
    font "#{Rails.root}/public/font2.ttf"
    #stroke_axis
    header
    simple_info
    education
    experience
    skills
    languages
    hobbies
    ending
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    y_position = cursor

    fill_color "4f6d7af"
    fill { rectangle [0, y_position], 540, 40 }
    fill_color "000000"

    bounding_box([10, y_position], :width => 40, :height => 40) do
      #stroke_bounds
      move_down 8
      image "#{Rails.root}/app/assets/images/vlk_pdf.png", height: 24
    end

    bounding_box([0, y_position], width: bounds.right, height: 40) do
      #stroke_bounds
      move_down 12
      text "Tomáš Koutský | (web) vývojář a administrátor | #{@user.age} let", size: 15, color: "FFFFFF", align: :center
    end

  end

  def simple_info
    y_position = cursor - 30

    bounding_box([140, y_position], width: 160, height: 100) do
      #stroke_bounds
      text "Specializace:", size: 12, color: "999999"
      move_down 40
      text "Vzdělání:", size: 12, color: "999999"
      text "Občanství:", size: 12, color: "999999"

    end

    bounding_box([260, y_position], width: 220, height: 100) do
      #sstroke_bounds
      if @user.simple_user_infos.any?
        text @user.simple_user_infos.find(1).info, size: 12
        text @user.simple_user_infos.find(2).info, size: 12
        text @user.simple_user_infos.find(3).info, size: 12
        move_down 10
      end
      text "středoškolské", size: 12
      text "české", size: 12


    end

    bounding_box([140, y_position - 100], width: 160, height: 100) do
      #stroke_bounds
      text "Bydliště:", size: 12, color: "999999"
      text "E-mail:", size: 12, color: "999999"
      text "Telefon:", size: 12, color: "999999"
      text "Web:", size: 12, color: "999999"
    end

    bounding_box([260, y_position - 100], width: 330, height: 100) do
      #stroke_bounds
      text "Přerov nad Labem, 289 16", size: 12
      text @user.email, size: 12
      text @user.phone, size: 12
      text "http://stepnivlk.net", size: 12
    end
  end

  def education
    y_position = cursor - 40
    fill_color "4f6d7af"
    fill { rectangle [0, cursor], 540, 20 }
    fill_color "000000"

    bounding_box([0, cursor], width: bounds.right, height: 40) do
      #stroke_bounds
      move_down 3
      text "Vzdělání", size: 12, color: "FFFFFF", align: :center
    end

    bounding_box([140, y_position], width: 160, height: 100) do
      #stroke_bounds
      @user.educations.each do |edu|
        text year_or_default(edu.start) + " - " + year_or_default(edu.end), size: 12, color: "999999"
        move_down 52      
      end
    end

    bounding_box([260, y_position], width: 330, height: 100) do
      #stroke_bounds
      @user.educations.each do |edu|
        text edu.name, size: 12
        move_down 3
        text edu.body.lines[0..2].join, size: 12
        move_down 10
      end
    end
  end

  def experience
    y_position = cursor - 40
    fill_color "4f6d7af"
    fill { rectangle [0, cursor], 540, 20 }
    fill_color "000000"

    bounding_box([0, cursor], width: bounds.right, height: 40) do
      #stroke_bounds
      move_down 3
      text "Zkušenosti", size: 12, color: "FFFFFF", align: :center
    end

    bounding_box([140, y_position], width: 160, height: 100) do
      #stroke_bounds
      @user.experiences.each do |ex|
        text year_or_default(ex.start) + " - " + year_or_default(ex.end), size: 12, color: "999999"
        move_down 52      
      end
    end

    bounding_box([260, y_position], width: 330, height: 300) do
      #stroke_bounds
      @user.experiences.each do |ex|
        body = ex.body.gsub(/\[/, '').gsub(/\)/, '').gsub(/\]\(/, ' - ')
        text ex.name, size: 12
        move_down 3
        text body, size: 12
        move_down 10
      end
    end    

  end

  def skills
    start_new_page
    y_position = cursor - 40
    fill_color "4f6d7af"
    fill { rectangle [0, cursor], 540, 20 }
    fill_color "000000"

    bounding_box([0, cursor], width: bounds.right, height: 20) do
      #stroke_bounds
      move_down 3
      text "Kompetence", size: 12, color: "FFFFFF", align: :center
    end

    bounding_box([140, y_position], width: 160, height: 200) do
      #stroke_bounds
      @user.skills.order('in_love_index DESC').each do |skill|
        text "#{skill.skill}:", size: 12, color: "000000" 
      end
    end

    height = 200
    bounding_box([260, y_position], width: 200, height: height) do
      #stroke_bounds
      i = 14.2
      size = height - (@user.skills.size * i)
      @user.skills.order('in_love_index DESC').reverse_each do |skill|
        fill_color "4f6d7af"
        fill { rectangle [0, size+i], (skill.skill_index*10), 10 }
        fill_color "c0d6df"
        fill { rectangle [skill.skill_index*10, size+i], (100-(skill.skill_index*10)), 10 }
        i += 14.2
      end
      fill_color "000000"
    end   

  end

  def languages
    y_position = cursor - 40
    fill_color "4f6d7af"
    fill { rectangle [0, y_position], 540, 20 }
    fill_color "000000"

    bounding_box([0, y_position], width: bounds.right, height: 40) do
      #stroke_bounds
      move_down 3
      text "Jazyky", size: 12, color: "FFFFFF", align: :center
    end

    y_position -= 40

    bounding_box([140, y_position], width: 160, height: 100) do
      #stroke_bounds
      text "Čeština:", size: 12, color: "000000"
      text "Angličtina:", size: 12, color: "000000"
      text "Ruština:", size: 12, color: "000000"

    end

    bounding_box([260, y_position], width: 200, height: 100) do
      #stroke_bounds
      i = 14.2
      fill_color "4f6d7af"
      fill { rectangle [0, 100], 90, 10 }
      fill_color "c0d6df"
      fill { rectangle [90, 100], 10, 10 }

      fill_color "4f6d7af"
      fill { rectangle [0, 100-i], 70, 10 }
      fill_color "c0d6df"
      fill { rectangle [70, 100-i], 30, 10 }

      fill_color "4f6d7af"
      fill { rectangle [0, 100-(i*2)], 10, 10 }
      fill_color "c0d6df"
      fill { rectangle [10, 100-(i*2)], 90, 10 }

      fill_color "000000"
    end

  end

  def hobbies
    y_position = cursor - 40
    fill_color "4f6d7af"
    fill { rectangle [0, y_position], 540, 20 }
    fill_color "000000"

    bounding_box([0, y_position], width: bounds.right, height: 40) do
      #stroke_bounds
      move_down 3
      text "Další zájmy", size: 12, color: "FFFFFF", align: :center
    end

    y_position -= 40
    bounding_box([0, y_position], width: bounds.right, height: 100) do
      text "Vysokohorská turistika", size: 12, color: "000000", align: :center
      text "Běhání ultramaratonů", size: 12, color: "000000", align: :center
      text "Fotografování", size: 12, color: "000000", align: :center
      text "Cestování", size: 12, color: "000000", align: :center
      text "Čtení", size: 12, color: "000000", align: :center

    end
  end

  def ending
    y_position = cursor - 20

    bounding_box([0, y_position], width: bounds.right, height: 120) do
      #stroke_bounds
      image "#{Rails.root}/app/assets/images/wolf-section-pdf.png", height: 120, position: :center
    end
  end

  def year_or_default(date, default="nyní")
    return date.strftime("%Y") if date
    return default
  end

end