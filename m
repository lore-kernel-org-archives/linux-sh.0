From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 10 Aug 2008 15:31:46 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support, v2.
Message-Id: <20080810153146.GA29351@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080731104354.GA21764@linux-sh.org> <20080810162931.3d9221af@hyperion.delvare> <20080810145053.GA9412@renesas.com> <20080810171342.14844957@hyperion.delvare>
In-Reply-To: <20080810171342.14844957@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-sh@vger.kernel.org

On Sun, Aug 10, 2008 at 05:13:42PM +0200, Jean Delvare wrote:
> On Sun, 10 Aug 2008 23:50:54 +0900, Paul Mundt wrote:
> > Hopefully that's answered above. Let me know if you have any other
> > concerns or suggestions.
> 
> OK. I've fixed the strlcpy size issue myself, together with a couple
> checkpatch warnings. The resulting patch is there:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-renesas-highlander-fpga-smbus-support.patch
> It is queued for 2.6.28.
> 
Looks good, thanks Jean.
