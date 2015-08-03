From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 03 Aug 2015 15:52:02 +0000
Subject: Re: Traceback in -next due to commit 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interfa
Message-Id: <20150803155155.GF21529@linux>
List-Id: <linux-sh.vger.kernel.org>
References: <55AD6314.2050000@roeck-us.net>
 <20150721023114.GD4994@linux>
 <55ADB37C.5020306@roeck-us.net>
 <CAMuHMdXpxcu_Rmi6p6JvAwB8Tr19Fr7oEBVbWXN1G0QyYPVr2g@mail.gmail.com>
In-Reply-To: <CAMuHMdXpxcu_Rmi6p6JvAwB8Tr19Fr7oEBVbWXN1G0QyYPVr2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On 03-08-15, 17:03, Geert Uytterhoeven wrote:
> I'm seeing the same WARNING on ARM (r8a7740/armadillo), and it's fixed by
> your patch.
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks. Daniel is back now and we should see this in linux-next soon.

-- 
viresh
