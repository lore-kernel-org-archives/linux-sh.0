From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Nov 2008 12:26:34 +0000
Subject: Re: [PATCH] sh: Add platform-specific constants for SH7709
Message-Id: <20081125122633.GA20883@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1227450442-31915-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1227450442-31915-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 23, 2008 at 02:27:21PM +0000, Steve Glendinning wrote:
> I'm using these constants in support of an in-house development board,
> and thought they may be useful to other users of SH7709.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>

On Sun, Nov 23, 2008 at 02:27:22PM +0000, Steve Glendinning wrote:
> sh7709 hardware manual says DMAOR is 16 bits long on this platform.
> 
> Tested and working with a modified smsc911x ethernet driver (sh-dma
> support patch for this driver is coming soon).
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>

On Sun, Nov 23, 2008 at 03:00:31PM +0000, Steve Glendinning wrote:
> The SH7709 datasheet defines bit 5 as set for burst mode, clear for
> cycle-steal mode.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>

These are all applied, thanks.
