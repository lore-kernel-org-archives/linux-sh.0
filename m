From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 11 Dec 2008 11:07:03 +0000
Subject: Re: [PATCH 4/6] smsc911x: convert ap325rxa platform to use smsc911x
Message-Id: <20081211110702.GA13147@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49266715.9090705@renesas.com>
In-Reply-To: <49266715.9090705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 11, 2008 at 10:49:06AM +0000, Steve.Glendinning@smsc.com wrote:
> Hi Paul,
> 
> The first two patches in this set (platform independant) are in the 
> net-next tree for merging in 2.6.29.  I guess the three sh-specific 
> patches would make more sense to merge via the sh tree, but they depend on 
> 1 and 2.  Do we need to wait until the merge window is open to add these?
> 
> Please let me know if you want me to re-send the 3 sh patches.
> 
I usually merge twice during the merge window, once with all of the stuff
pending in my tree, and then a second time nearer the end of the window
once all of the trees I have patches with dependencies on are merged. I
will include your patches along with those, so by the time the merge
window is nearing an end, everything should be settled.
