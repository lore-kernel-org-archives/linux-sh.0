From: Manuel Lauss <mlau@msc-ge.com>
Date: Thu, 31 Jul 2008 05:13:19 +0000
Subject: Re: i2c_board_info use
Message-Id: <489149EF.3050501@msc-ge.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48906795.9040101@spesonline.com>
In-Reply-To: <48906795.9040101@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Luca Santini wrote:
> Thanks Manuel.
> I'm trying the conversion.
> A last (i hope for you) question: i cross-compiled alsa-lib and 
> alsa-utils but i don't know how to configure alsa without alsaconf and 
> alsamixer (no lspci, no lsmod, no ncurses avaiable)

As far as I know, you just need to install alsa-lib correctly on the
target (make sure you have a /usr/share/alsa/alsa.conf file).

Manuel Lauss
