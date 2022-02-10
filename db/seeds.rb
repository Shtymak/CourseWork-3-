if Rails.env.development?
  AdminUser.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  ConfigView.create!(locale: 'uk',
                     data: { 'link_to_facebook': 'https://www.facebook.com/balu.kiev/',
                             'link_to_instagram': 'https://www.instagram.com/balu_kyiv/',
                             phone: '+380 (96) 052 0755',
                             email: 'balu.kyiv@gmail.com',
                             merchant_id: '1396424' })

  categories = []
  dishes = []
  variants = []

  categories << [
    {
      name: 'Салати',
      name_en: 'Salads',
      sequence_number: 1
    },
    {
      name: 'Гарячі закуски м’ясо та риба',
      name_en: 'Starters meat and fish',
      sequence_number: 2
    },
    {
      name: 'Вегетаріанські закуски',
      name_en: 'Vegeterian dishes and paneer',
      sequence_number: 3
    },
    {
      name: 'Супи',
      name_en: 'SOUP',
      sequence_number: 4
    },
    {
      name: "Основні страви м'ясо та риба",
      name_en: 'Main course meat ang fish',
      sequence_number: 5
    },
    {
      name: 'Рис',
      name_en: 'RICE',
      sequence_number: 6
    },
    {
      name: 'Вегетаріанські страви',
      name_en: 'Vegetarian dishes',
      sequence_number: 5
    },
    {
      name: 'Індійський хліб з тандуру',
      name_en: 'indian bread from tandoor',
      sequence_number: 7
    },
    {
      name: 'Десерти',
      name_en: 'Desserts',
      sequence_number: 8
    }
  ]
  Category.first_or_create(categories)

  variants << [
    {
      name: 'Солодко',
      name_en: ''
    },
    {
      name: 'Гостро',
      name_en: ''
    },
    {
      name: 'Дуже гостро',
      name_en: ''
    }
  ]

  Variant.first_or_create(variants)

  dishes << [
    {
      name: 'Овочевий салат',
      name_en: Faker::Food.dish,
      description: 'томат, огірок, болгарський перець та цибуля, заправлені оливковою олією',
      description_en: Faker::Movie.quote,
      price: 78,
      weight: '300',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Салати').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Авокадо Прон Салат',
      name_en: Faker::Food.dish,
      description: 'салат із пюре авокадо з криветками',
      description_en: Faker::Movie.quote,
      price: 198,
      weight: '1 шт',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Салати').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Тандурі Вудж Салат',
      name_en: Faker::Food.dish,
      description: 'мікс овочів тапаніру,запечених зі сеціями в тандурі',
      description_en: Faker::Movie.quote,
      price: 167,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Салати').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Шик Кебаб',
      name_en: Faker::Food.dish,
      description: 'рублена баранин, запечена в тандурі',
      description_en: Faker::Movie.quote,
      price: 194,
      weight: '200',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Гарячі закуски м’ясо та риба').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Тандурі Чікен',
      name_en: Faker::Food.dish,
      description: 'курячі стегенця, запечені в тандурі',
      description_en: Faker::Movie.quote,
      price: 218,
      weight: '400',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Гарячі закуски м’ясо та риба').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Решмі Кебаб',
      name_en: Faker::Food.dish,
      description: 'куряче філе, мариноване в гострому соусі, запечене в тандурі',
      description_en: Faker::Movie.quote,
      price: 218,
      weight: '400',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Гарячі закуски м’ясо та риба').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Овочева Пакора',
      name_en: Faker::Food.dish,
      description: 'овочі в горохову клярі, обсмажені у фритюрі',
      description_en: Faker::Movie.quote,
      price: 138,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Вегетаріанські закуски').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Панір Тікка',
      name_en: Faker::Food.dish,
      description: 'шматочки паніру, запечені з овочами в тандурі',
      description_en: Faker::Movie.quote,
      price: 167,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Вегетаріанські закуски').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Ведж Ачар',
      name_en: Faker::Food.dish,
      description: 'гриби з броколі, замариновані в пряному соусі ачар та запечені в тандурі',
      description_en: Faker::Movie.quote,
      price: 152,
      weight: '200',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Вегетаріанські закуски').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Дал Суп',
      name_en: Faker::Food.dish,
      description: 'Пряний суп з жовтої сочевиці',
      description_en: Faker::Movie.quote,
      price: 88,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Супи').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Світ Корн Суп',
      name_en: Faker::Food.dish,
      description: 'Суп із кукурудзою, свіжими овочами та спеціями',
      description_en: Faker::Movie.quote,
      price: 84,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Супи').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Мадрас Карі',
      name_en: Faker::Food.dish,
      description: "Шматочки курячого філе в традиційному соусі 'Карі'",
      description_en: Faker::Movie.quote,
      price: 198,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: "Основні страви м'ясо та риба").id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Чікен Сагвала',
      name_en: Faker::Food.dish,
      description: 'шматочки курячого філе в соусі зі шпинату та спеціями',
      description_en: Faker::Movie.quote,
      price: 198,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: "Основні страви м'ясо та риба").id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },

    {
      name: 'Алу Гобі',
      name_en: Faker::Food.dish,
      description: 'тушкована картопляз цвітною капустою та спеціями',
      description_en: Faker::Movie.quote,
      price: 138,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Вегетаріанські страви').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Шахі панір',
      name_en: Faker::Food.dish,
      description: 'шміточки паніру в горіхово-томатному соусі',
      description_en: Faker::Movie.quote,
      price: 138,
      weight: '250',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Вегетаріанські страви').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Білий Рис',
      name_en: Faker::Food.dish,
      description: 'індійський басматі рис',
      description_en: Faker::Movie.quote,
      price: 75,
      weight: '200',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Рис').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Джарі Рис',
      name_en: Faker::Food.dish,
      description: 'індійський басматі рис з кмином',
      description_en: Faker::Movie.quote,
      price: 78,
      weight: '200',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Рис').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Пілоу Рис',
      name_en: Faker::Food.dish,
      description: 'рис з шафраном та куркою',
      description_en: Faker::Movie.quote,
      price: 76,
      weight: '200',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Рис').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Нан',
      name_en: Faker::Food.dish,
      description: 'індійський хліб із світлого борошна',
      description_en: Faker::Movie.quote,
      price: 44,
      weight: '120',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Індійський хліб з тандуру').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Тандуру Роті',
      name_en: Faker::Food.dish,
      description: 'індійський хліб із цільозернового борошна',
      description_en: Faker::Movie.quote,
      price: 44,
      weight: '120',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Індійський хліб з тандуру').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Барфі',
      name_en: Faker::Food.dish,
      description: 'традиційний кокосово молочний десерт',
      description_en: Faker::Movie.quote,
      price: 88,
      weight: '100',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Десерти').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    },
    {
      name: 'Манго пюре',
      name_en: Faker::Food.dish,
      description: '',
      description_en: '',
      price: 92,
      weight: '100',
      is_published: true,
      is_delivered: true,
      category_id: Category.find_by(name: 'Десерти').id,
      variants: Variant.all,
      is_active_from_delivered: false,
      set_image: 'https://picsum.photos/400'
    }
  ]
  Dish.first_or_create(dishes)
end
