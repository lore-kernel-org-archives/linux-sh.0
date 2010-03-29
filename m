From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Mar 2010 06:29:45 +0000
Subject: Re: [PATCH] sh: pteaex tlb debugfs support
Message-Id: <20100329062945.GA27621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5710cd68d399fc83734fcde7116ab91a3cfd624d.1269806831.git.matt@console-pimps.org>
In-Reply-To: <5710cd68d399fc83734fcde7116ab91a3cfd624d.1269806831.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 28, 2010 at 09:09:08PM +0100, Matt Fleming wrote:
> Export the status of the utlb and itlb entries through sysfs.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

I've rolled it in to the local patch I had for this and pushed out a
split out version. It would be nice to also set up the tlb_info bits in
the probe code since they're presently unused and this could be made more
generic (while also allowing us to kill off more of the header mess).
