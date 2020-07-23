From: Rich Felker <dalias@libc.org>
Date: Thu, 23 Jul 2020 18:02:32 +0000
Subject: Re: Suggested patches for merging
Message-Id: <20200723180231.GB6949@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
In-Reply-To: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 23, 2020 at 07:56:24PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 7/23/20 7:52 PM, Rich Felker wrote:
> > Have you checked my for-next? It already has all of these except the
> > new seccomp series.
> 
> I haven't checked yet as last time I did a check-out the connection
> was rather slow to me.
> 
> Might be better if you get a tree on kernel.org.

I would love to have one, and was trying to get it for years, but the
ridiculous stone-age PGP policy and flakiness of folks who said they'd
sign keys but never did has prevented it. This is 2020 and I can
easily publish a fingerprint through multiple channels I'm known
through in a way that couldn't plausibly be fake on all of them.
Getting a key trusted should not depend on meeting people in person
and trusting them to follow up with signing.

In the mean time, I recommend a "git fetch --tags" from linus's main
tree followed by pull from mine to keep the volume of the latter down.

Rich
