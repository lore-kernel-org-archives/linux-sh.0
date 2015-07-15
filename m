From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 06:55:16 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig
Message-Id: <20150715065516.GD5071@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436942555-4851-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoT=8Oyr2Bb10dnvQAe0LzMsQk3VZw6ZN5YSJ=UDcBnLSQ@mail.gmail.com>
In-Reply-To: <CANqRtoT=8Oyr2Bb10dnvQAe0LzMsQk3VZw6ZN5YSJ=UDcBnLSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 15, 2015 at 03:47:59PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 15, 2015 at 3:42 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > This is selected by MACH_MARZEN which is enabled in shmobile_defconfig,
> > however, MACH_MARZEN is going away along with the board code it enables.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for dealing with this, looking good!

Thanks, I will shuffle things a bit so this is queued up before the patch
that removes the marzen-reference board code and MACH_MARZEN.
