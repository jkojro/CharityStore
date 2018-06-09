require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Potwierdzenie złożenia zamówienia w Charity store", mail.subject
    assert_equal ["janusz@gmail.com"], mail.to
    assert_equal ["habrafilm@gmail.com"], mail.from
    assert_match /1 x Example title/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Twój towar z Charity Store został wysłany", mail.subject
    assert_equal ["janusz@gmail.com"], mail.to
    assert_equal ["habrafilm@gmail.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Example title<\/td>/, mail.body.encoded
  end

end
