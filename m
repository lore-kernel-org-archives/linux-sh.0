From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jul 2014 05:00:52 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: r7s72100: Remove legacy board support
Message-Id: <20140715050052.GF5277@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 07, 2014 at 08:13:35AM +0200, Wolfram Sang wrote:
> On Wed, Jul 02, 2014 at 06:23:35PM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > Now that all features supported by the Genmai legacy and reference board files
> > are supported using DT boot on a multiplatform kernel, remove support for the
> > Genmai board code and legacy (non multiplatform) r7s72100 code.
> > 
> > This patch set is based on top of and depends on the Genmai MTU2 DT patch
> > ("ARM: shmobile: genmai-reference: Enable MTU2 in device tree").
> 
> Acked-by: Wolfram Sang <wsa@sang-engineering.com>

Thanks, I have queued these up.

