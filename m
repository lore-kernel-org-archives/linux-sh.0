From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 23 Mar 2012 07:18:32 +0000
Subject: Re: [PATCH v2] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <20120323071831.GH26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 23, 2012 at 01:38:38PM +0900, Nobuhiro Iwamatsu wrote:
> Paul Mundt ????????????????????????:
> >On Wed, Mar 21, 2012 at 03:47:00PM +0900, Nobuhiro Iwamatsu wrote:
> >>In devices using ehci-sh, initialization of the PHY may be necessary.
> >>This adds platform data to ehci-sh and provide function to initialize PHY.
> >>
> >>Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> >>CC: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
> >
> >It's impossible to say whether this makes sense or not without first
> >seeing what you are trying to do in the callback.
> >
> 
> For example, it is necessary to initialize it after having
> ebabled clock of ehci in sh7734.
> I perform initialization CPU specific in callback.
> For example, following.
> 
Ok, that seems fine. I'd prefer to see the header in
include/linux/platform_data/, however. Also, when can we expect an
upstream user for this? I don't mind adding support for it, but it
doesn't make much sense to have upstream if there aren't any in-tree
users.
