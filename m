From: Eduardo Valentin <edubezval@gmail.com>
Date: Thu, 12 Nov 2015 18:43:26 +0000
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Message-Id: <20151112184325.GB5289@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <2060819.A5Wq9BbBOH@vostro.rjw.lan>
 <CAPDyKFpzHjHfJjxupaSDabmSQzCD8M9enAFQDe0NnMn6-9g0pg@mail.gmail.com>
 <1611120.Ji2Kgxk0bH@vostro.rjw.lan>
 <CAPDyKFqK0qSVvY7UJM5VYmjfMkEwWw9JG74t_uMcem09g+uHAw@mail.gmail.com>
In-Reply-To: <CAPDyKFqK0qSVvY7UJM5VYmjfMkEwWw9JG74t_uMcem09g+uHAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?utf-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>

Hello,

On Thu, Nov 12, 2015 at 09:04:09AM +0100, Ulf Hansson wrote:
> >
> > OK
> >
> > If we did that, all devices that had just been unbound from their drivers
> > and had runtime PM disabled after that would be set to "suspended" by the
> > core, right?
> 
> Yes, that's the idea. I will send a patch we can test.
> 
> >
> > If that helps, I don't really have objections.

Given this discussion,

Is this series of two patches on this thermal driver still applicable?


BR,

Eduardo

> >
> 
> Thanks!
> 
> Kind regards
> Uffe
