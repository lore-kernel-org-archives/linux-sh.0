From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 20 Aug 2020 22:14:35 +0000
Subject: Re: [PATCH 0/3] rtc: rtc-rs5c313: Fix and cleanups
Message-Id: <159796165864.2239639.901039346229780391.b4-ty@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200814110731.29029-1-geert+renesas@glider.be>
In-Reply-To: <20200814110731.29029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alessandro Zummo <a.zummo@towertech.it>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-rtc@vger.kernel.org, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, kogiidena <kogiidena@eggplant.ddo.jp>

On Fri, 14 Aug 2020 13:07:28 +0200, Geert Uytterhoeven wrote:
> 	Hi Ale{ss,x}andr[oe],
> 
> This patch series fixes the RS5C313 RTC driver, which is used on the I-O
> DATA USL-5P aka Landisk:
> 
>     -rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
>      rs5c313 rs5c313: registered as rtc0
>     -rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
>     -rs5c313 rs5c313: hctosys: unable to read the hardware clock
>     +rs5c313 rs5c313: setting system clock to 2020-08-14T01:04:12 UTC (1597367052)
> 
> [...]

Applied, thanks!

[1/3] rtc: rtc-rs5c313: Drop obsolete platform_set_drvdata() call
      commit: fc9656a370499e5a32425b715f8fed241e832458
[2/3] rtc: rtc-rs5c313: Fix late hardware init
      commit: f65e727464d7c0090f05548e8f323779eaa97eda
[3/3] rtc: rtc-rs5c313: Convert to module_platform_driver()
      commit: 163a512cd929d6db712a3021720362749653998b

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
