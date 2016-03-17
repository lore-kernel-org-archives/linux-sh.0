From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 17 Mar 2016 09:10:26 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56EA7482.9050304@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich!

On 03/17/2016 04:24 AM, Rich Felker wrote:
> I'm working on the J-Core (currently J2) open hardware revival of the
> SH architecture and don't have any original SH hardware (except
> perhaps embedded in old appliances). Does anyone have pointers (direct
> add-to-cart'able links) to where SH dev boards are still available, or
> even better, any old hardware lying around that's not being used that
> you'd be willing to donate?

I have acquired SuperH hardware in the past and I have good contacts
to people in Japan. I will help you getting a board, but it may take
a while.

Since Renesas dropped support for SuperH completely, they don't have
any evaluation boards left. In fact, I own the last board that they
had in stock.

So, with Renesas out of the picture, sources for SuperH hardware would
be either open source people in Japan who used to work for Renesas -
I know, for fact, that Renesas hired lots of people in Japan to work
on SuperH support in Linux - or third-party companies like emtrion [1]
or Alpha Project in Japan [2]. Another option would be getting an
old LANDisk device which can also be used to run Debian's sh4 port [3].

I have already forwarded your mail to a friend in the Japanese Debian
community and asked him to post a mail in Japanese on their mailing
lists asking for people who are willing to donate hardware.

We will find something for you :).

Adrian

> [1] https://www.emtrion.de/en/legacy_products.html
> [2] http://www.apnet.co.jp/product/superh/
> [3] http://www.iodata.jp/product/nas/personal/hdl-u/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
