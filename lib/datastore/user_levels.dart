import 'package:multitables/models/user_level.dart';

const USER_LEVELS = const [
  UserLevel(id: 1, name: '1', icon: '022-lemur.png', number: 0),
  UserLevel(id: 2, name: '2', icon: '008-sloth.png', number: 20), // +20
  UserLevel(id: 3, name: '3', icon: '031-meerkat.png', number: 50), // +30
  UserLevel(id: 4, name: '4', icon: '050-fox.png', number: 80), // +30
  UserLevel(id: 5, name: '5', icon: '001-panda.png', number: 120), // +40
  UserLevel(id: 6, name: '6', icon: '005-parrot.png', number: 160), // +40
  UserLevel(id: 7, name: '7', icon: '006-rabbit.png', number: 200), // +40
  UserLevel(id: 8, name: '8', icon: '007-chameleon.png', number: 250), //+50
  UserLevel(id: 9, name: '9', icon: '009-elk.png', number: 300), //+50
  UserLevel(id: 10, name: '10', icon: '010-llama.png', number: 360), // +60
  UserLevel(id: 11, name: '11', icon: '014-beaver.png', number: 420), //+60
  UserLevel(id: 12, name: '12', icon: '017-bear.png', number: 500), //+80
  UserLevel(id: 13, name: '13', icon: '013-crocodile.png', number: 580), //+80
  UserLevel(id: 14, name: '14', icon: '012-eagle.png', number: 680), //+100
  UserLevel(id: 15, name: '15', icon: '020-duck.png', number: 780), //+100
  UserLevel(id: 16, name: '16', icon: '015-hamster.png', number: 880), //+100
  UserLevel(id: 17, name: '17', icon: '016-walrus.png', number: 1000), //+120
  UserLevel(id: 18, name: '18', icon: '040-koala.png', number: 1130), //+130
  UserLevel(id: 19, name: '19', icon: '018-cheetah.png', number: 1270), //+140
  UserLevel(id: 20, name: '20', icon: '024-owl.png', number: 1430), //+150
  UserLevel(id: 21, name: '21', icon: '021-goose.png', number: 1590), //+160
  UserLevel(id: 22, name: '22', icon: '026-penguin.png', number: 1760), //+170
  UserLevel(id: 23, name: '23', icon: '019-kangaroo.png', number: 1940), //+180
  UserLevel(id: 24, name: '24', icon: '028-raccoon.png', number: 2130), // +190
  UserLevel(id: 25, name: '25', icon: '025-boar.png', number: 2330), // +200
  UserLevel(id: 26, name: '26', icon: '029-hippo.png', number: 2530), // +200
  UserLevel(id: 27, name: '27', icon: '023-ostrich.png', number: 2730), // +200
  UserLevel(id: 28, name: '28', icon: '030-monkey.png', number: 2930), // +200
  UserLevel(id: 29, name: '29', icon: '032-snake.png', number: 3200),
  UserLevel(id: 30, name: '30', icon: '033-zebra.png', number: 3500),
  UserLevel(id: 31, name: '31', icon: '034-donkey.png', number: 3800),
  UserLevel(id: 32, name: '32', icon: '002-lion.png', number: 4100),
  UserLevel(id: 33, name: '33', icon: '035-bull.png', number: 4400),
  UserLevel(id: 34, name: '34', icon: '037-goat.png', number: 4700),
  UserLevel(id: 35, name: '35', icon: '027-camel.png', number: 5000),
  UserLevel(id: 36, name: '36', icon: '039-wolf.png', number: 5300),
  UserLevel(id: 37, name: '37', icon: '046-deer.png', number: 5600),
  UserLevel(id: 38, name: '38', icon: '038-horse.png', number: 5900),
  UserLevel(id: 39, name: '39', icon: '003-tiger.png', number: 6200),
  UserLevel(id: 40, name: '40', icon: '044-gorilla.png', number: 6500),
  UserLevel(id: 41, name: '41', icon: '036-goat-1.png', number: 6800),
  UserLevel(id: 42, name: '42', icon: '041-hedgehog.png', number: 7200),
  UserLevel(id: 43, name: '43', icon: '043-turtle.png', number: 7600),
  UserLevel(id: 44, name: '44', icon: '047-rhinoceros.png', number: 8000),
  UserLevel(id: 45, name: '45', icon: '011-ant-eater.png', number: 8400),
  UserLevel(id: 46, name: '46', icon: '045-giraffe.png', number: 8900),
  UserLevel(id: 47, name: '47', icon: '004-bear-1.png', number: 9500),
  UserLevel(id: 48, name: '48', icon: '042-frog.png', number: 10500),
  UserLevel(id: 49, name: '49', icon: '049-puma.png', number: 12000),
  UserLevel(id: 50, name: '50', icon: '048-elephant.png', number: 15000),
  UserLevel(id: 51, name: '51', icon: '003-giraffe.png', number: 20000),
  UserLevel(id: 52, name: '52', icon: '004-elephant.png', number: 25000),
  UserLevel(id: 53, name: '53', icon: '007-bird.png', number: 30000),
  UserLevel(id: 54, name: '54', icon: '015-ara-macao.png', number: 35000),
  UserLevel(id: 55, name: '55', icon: '021-lion.png', number: 40000),
  UserLevel(id: 56, name: '56', icon: '024-panther.png', number: 45000),
  UserLevel(id: 57, name: '57', icon: '025-rhinoceros.png', number: 50000),
  UserLevel(id: 58, name: '58', icon: '026-zebra.png', number: 60000),
  UserLevel(id: 59, name: '59', icon: '031-crocodile.png', number: 70000),
  UserLevel(id: 60, name: '60', icon: '032-frog.png', number: 80000),
  UserLevel(id: 61, name: '61', icon: '034-snake.png', number: 90000),
  UserLevel(id: 62, name: '62', icon: '048-monkey.png', number: 100000),
  UserLevel(id: 63, name: '63', icon: '049-tiger.png', number: 120000),
  UserLevel(id: 64, name: '64', icon: '050-hippopotamus.png', number: 140000),
  UserLevel(id: 65, name: '65', icon: '043-creature.png', number: 180000),
  UserLevel(id: 66, name: '66', icon: '010-totem.png', number: 250000),
  UserLevel(id: 67, name: '67', icon: '010-totem.png', number: 1000000),
  UserLevel(id: 68, name: '68', icon: '010-totem.png', number: 2000000),
];
