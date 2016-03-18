From: Sergei Ianovich <ynvich@gmail.com>
Date: Fri, 18 Mar 2016 10:38:15 +0000
Subject: Re: [PATCH v7] rtc: rewrite DS1302 using SPI
Message-Id: <1458297495.3499.29.camel@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
	 <1456224900-4877-1-git-send-email-ynvich@gmail.com>
	 <20160315001844.GJ28277@piout.net>
In-Reply-To: <20160315001844.GJ28277@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:REAL TIME CLOCK RTC SUBSYSTEM" <rtc-linux@googlegroups.com>, linux-sh@vger.kernel.org

On Tue, 2016-03-15 at 01:18 +0100, Alexandre Belloni wrote:
> I would like to have a solution for secureedge5410 even if it is
> untested. Else, we are breaking an existing platform without any
> solution.
> 
> I've put the sh maintainers in copy, maybe they have an opinion. Else
> I'll let your patch sit in linux-next for the next cycle.

secureedge5410 will need an SPI host driver. The driver will be similar
to the one I did for lp8841. I can make a clone for secureedge5410, but
I cannot test it.

The only reason, I didn't file the patch for secureedge5410, is I
thought SPI people won't accept an untested patch.
