From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 03 Apr 2014 08:30:44 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo-reference dts: enable RTC
Message-Id: <CAO3366yPCSHVLV9cQaaX7nixC8KHmzmPi8EzvTh+Zxd1bwVcXQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

On Thu, Apr 3, 2014 at 2:11 AM, Simon Horman <horms@verge.net.au> wrote:
> I am a little confused about i2c2 appearing below as
> the documentation that I have only seems to refer to
> the presence of i2c0 and i2c1.

This thing doesn't use any of the SoC I2C controllers, it's just
hooked up to two GPIO pins. The board docs don't give much detail, but
I found the relevant info in the Android vendor kernel, which is where
this "bus" is called i2c2. The name is arbitrary, though.

CU
Uli
