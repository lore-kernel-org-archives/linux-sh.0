From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 02 Oct 2012 12:24:57 +0000
Subject: Re: GPIO request failure with PCF pinmux
Message-Id: <1674410.rS86A9UHuy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <6045802.ynsOILKLIK@avalon>
In-Reply-To: <6045802.ynsOILKLIK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

On Tuesday 18 September 2012 16:22:38 Paul Mundt wrote:
> On Fri, Sep 14, 2012 at 10:36:34PM +0200, Laurent Pinchart wrote:
> > And while I'm at it, trying to set the pin to the PWM function doesn't
> > seem to work anymore on v3.6. It looks like the pin stays configured as a
> > GPIO. How am I supposed to configure pinmuxing from the driver ?
> > Documentation/pinctrl.txt doesn't help much, and the code isn't easy to
> > understand. There's probably no registered mapping (whatever a mapping
> > is), are they supposed to come from DT ?
> 
> For the moment requesting as a function as before should be fine,
> although it's possible that your config-as-gpio reconfig-as-function flow
> has tripped up some of the logic. Both were tested independently, but as
> you can tell I've overlooked the reuse of the same pin by the same driver
> in different ways case.
> 
> And yes, you've hit on the next phase of the pfc rework. At present we
> have a GPIO shim that enables function requests via the GPIO API as
> before, but it's not the way we want to go forward and remains there only
> for backwards compatability.
> 
> More work needs to be done both in the drivers and the board/platform to
> make use of pinctrl mappings. I have some work in progress for sh-sci,
> but ran out of time to get it merged for this merge window.

What's the status of that work ? I'll have to implement pinctrl support for 
the H1 series, and having sample code would be helpful. Are there still core 
pieces missing ?

> The DT support is something else that has to be worked out. I personally
> have no interest in supporting DT, as I view the entire endeavour as nothing
> but a solution in search of a problem. If someone wants DT support for this
> they're welcome to hack something up, though. I won't oppose DT changes
> going in, regardless of whether they're ultimately a waste of time or not.

-- 
Regards,

Laurent Pinchart

