From: Kevin Hilman <khilman@kernel.org>
Date: Mon, 09 Mar 2015 21:00:27 +0000
Subject: Re: [PATCH v5 1/8] PM / Domains: Add DT bindings for power-on/off latencies
Message-Id: <CAMAWPa-PROLJVGU2w8FSJYt4YJehc2DAnaT047fukSTAM9Eddw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
 <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Mon, Nov 17, 2014 at 5:30 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.

Any plans to refresh/resend this patch now that the rest of the series
has gone in?

I'm seeing some other PM domain series coming in for review[1] that
could use this feature.

Thanks,

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328905.html
