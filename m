From: Rich Felker <dalias@libc.org>
Date: Sun, 16 Aug 2020 04:01:47 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <20200816040146.GX3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 15, 2020 at 10:24:28PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 8/15/20 12:40 PM, John Paul Adrian Glaubitz wrote:
> > On 8/15/20 4:17 AM, Rich Felker wrote:
> >>> Would it be possible to include Geert's fix for the IDE interface
> >>> of the LANDISK USL-5P devices [1]?
> >>
> >> Yep, I'm preparing the pull request and was just about to ask if it
> >> should be included. Anything else not in next already that should be?
> > 
> > Great.
> > 
> > Let me check out your -next tree and see what we already have.
> Just had a look and also compiled and test-ran the kernel from for-next
> on my SH7785LCR system. Works fine and all known issues are fixed.
> 
> So, from my side it's a go ahead ;-).

sh-for-5.9 (including the landisk fix) has been merged.

Rich
