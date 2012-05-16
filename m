From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 16 May 2012 20:05:08 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <201205162205.09082.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520> <CANqRtoTCo_Vwe8OMS2ovHNimoe_4ZnCEHk5TQ4YPq8oPJXMObg@mail.gmail.com> <CACRpkdb4iHomtj5Ue=HmHLLvH==wLuSoMA+uwrp3vTBAPnQr_g@mail.gmail.com>
In-Reply-To: <CACRpkdb4iHomtj5Ue=HmHLLvH==wLuSoMA+uwrp3vTBAPnQr_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, lethal@linux-sh.org, olof@lixom.net

On Wednesday, May 16, 2012, Linus Walleij wrote:
> On Wed, May 16, 2012 at 12:15 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > Do you guys have any preferences how to merge this?
> >
> > Can I include it together with the EMEV2 SoC bits perhaps? That may be
> > easy so we can keep track of the platform data header file dependency.
> 
> For ux500 I made a special "gpio and pins" branch and sent through ARM SoC.

The problem is we have a patch depending on the $subject one in the EMEV2
series and it would be better to keep them both together if that's not
a big deal.

Thanks,
Rafael
