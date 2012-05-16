From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2012 11:25:44 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CACRpkdb4iHomtj5Ue=HmHLLvH==wLuSoMA+uwrp3vTBAPnQr_g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<CACRpkdb9LbjvobsJf61VA1Nt8-UCwDZzmjqC8JuN8WPdvhq+iQ@mail.gmail.com>
	<CANqRtoTCo_Vwe8OMS2ovHNimoe_4ZnCEHk5TQ4YPq8oPJXMObg@mail.gmail.com>
In-Reply-To: <CANqRtoTCo_Vwe8OMS2ovHNimoe_4ZnCEHk5TQ4YPq8oPJXMObg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, lethal@linux-sh.org, olof@lixom.net

On Wed, May 16, 2012 at 12:15 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> Do you guys have any preferences how to merge this?
>
> Can I include it together with the EMEV2 SoC bits perhaps? That may be
> easy so we can keep track of the platform data header file dependency.

For ux500 I made a special "gpio and pins" branch and sent through ARM SoC.

Yours,
Linus Walleij
