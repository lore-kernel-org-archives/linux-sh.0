From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 26 Sep 2014 15:28:35 +0000
Subject: Re: [PATCH v3 02/13] PM / Domains: Add DT bindings for power-on/off latencies
Message-Id: <20140926152835.GK10233@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <1411662520-22795-3-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrAv9oyBzX764+CWkOxfN1kN_MddB3ks1q69+TnmnHXuQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrAv9oyBzX764+CWkOxfN1kN_MddB3ks1q69+TnmnHXuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> On 25 September 2014 18:28, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > +Optional properties:
> > + - power-on-latency: Power-on latency of the PM domain, in ns,
> > + - power-off-latency: Power-off latency of the PM domain, in ns.
> > +
> >  Example:
> >
> >         power: power-controller@12340000 {
> >                 compatible = "foo,power-controller";
> >                 reg = <0x12340000 0x1000>;
> >                 #power-domain-cells = <1>;
> > +               power-on-latency = <250000>;
> > +               power-off-latency = <250000>;

This assumes every power domain within a power controller has the
same latencies? That isn't always true. This should be an array
of values corresponding to the number of power domains if
#power-domain-cells is 1, or just one value if the cell count is
0.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
