From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 12:24:11 +0000
Subject: Re: [PATCH v2 4/8] ARM: shmobile: move GIC and I2C devices from sh73a0 common .dtsi to reference
Message-Id: <20130319122411.GE4317@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 19, 2013 at 09:14:16PM +0900, Simon Horman wrote:
> On Tue, Mar 19, 2013 at 12:25:24PM +0100, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Let me return briefly to this 1 month-old thread just to make sure we're 
> > happy about the current state of kzm9g DT:
> > 
> > On Wed, 13 Feb 2013, Simon Horman wrote:
> > 
> > > On Wed, Feb 13, 2013 at 10:59:41AM +0100, Guennadi Liakhovetski wrote:
> > > > Hi Simon
> > > > 
> > > > On Wed, 13 Feb 2013, Simon Horman wrote:
> > > > 
> > > > > On Fri, Feb 08, 2013 at 07:38:28PM +0100, Guennadi Liakhovetski wrote:
> > > > > > In "legacy" mode, when all devices are initialised by the board .c file,
> > > > > > there is no need to install the GIC and all I2C devices from the device
> > > > > > tree too. Move them to the reference implementation, that fully relies upon
> > > > > > DT.
> > > > > 
> > > > > The motivation for placing the code in sh73a0.dtsi was so that
> > > > > it would be available to the non-reference board code if/when it
> > > > > moves over to using DT.
> > > > > 
> > > > > I'm happy to switch things around if its preferred to keep
> > > > > the dts small.
> > > > 
> > > > As I said, I do think it is good to keep devices in a central .dtsi, 
> > > > included by all, but they should be disabled by default, using the 
> > > > 'status="disabled"' property, and only enabled on boards, that actually 
> > > > use those devices.
> > > 
> > > Ok, that makes sense to me. Do you think you could update this patch
> > > accordingly?
> > 
> > Here's my understanding of the DT situation on kzm9g:
> > 
> > 1. legacy board-kzm9g.c + sh73a0-kzm9g.dts + sh73a0.dtsi: board's 
> > struct machine_desc defines a .dt_compat field, this shall allow to 
> > include this kzm9g support in multiarch kernels, using DT. sh73a0.dtsi 
> > includes nodes for all I2C devices and the GIC interrupt controller, but 
> > of_platform_populate() is never called, so, those nodes are unused.
> > 
> > 2. DT mode board-kzm9g-reference.c + sh73a0-kzm9g-reference.dts + 
> > sh73a0-reference.dtsi + sh73a0.dtsi: .dt_compat is obviously used similar 
> > to the above, but with a different match string, of_platform_populate() is 
> > called, so i2c and gic nodes are used and respective devices are 
> > instantiated.
> > 
> > So, in principle all works as expected, but it just seems a bit unclean 
> > and confusing to me, that in "legacy" mode [1] above a bunch of devices 
> > are provided in DT, listed in /proc/device-tree/ but remain unused. using 
> > 'status="disabled"' as proposed above could be done, but having to add 
> > nodes like
> > 
> > &gic = {
> > 	status = "okay";
> > };
> > 
> > &i2c0...
> > 
> > on all boards, that do use DT, seems a bit clumsy to me.
> 
> What is the problem with having entries in sh73a0.dtsi which are unused
> in some modes? In the long run the plan is to use DT by default
> and remove board-kzm9g-reference.c, so it seems to me that
> it makes sense to put as much as possible into sh73a0.dtsi.
> 
> My preference would be to remove sh73a0-kzm9g.dts, moving its
> contents into sh73a0.dtsi.

Sorry, s/sh73a0-kzm9g.dts/sh73a0-reference.dts/
