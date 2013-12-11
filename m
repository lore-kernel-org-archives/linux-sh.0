From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Dec 2013 02:09:04 +0000
Subject: Re: [PATCH 1/2] I2C: EMMA Mobile I2C master driver
Message-Id: <20131211020904.GK19992@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-2-git-send-email-ian.molton@codethink.co.uk>
 <20130905060429.GJ14960@verge.net.au>
 <20130925044503.GA24243@verge.net.au>
 <52A23916.40507@codethink.co.uk>
In-Reply-To: <52A23916.40507@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian.molton@codethink.co.uk>
Cc: magnus.damm@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk

On Fri, Dec 06, 2013 at 08:52:38PM +0000, Ian Molton wrote:
> On 25/09/13 05:45, Simon Horman wrote:
> 
> >Hi Ian,
> >
> >I spoke with Magnus and in turn Ben about this at LinuxCon in New Orleans
> >last week.
> >
> >Basically the position of Magnus and I is that any support for this
> >hardware is an incremental improvement on the current situation: no
> >support.
> >
> >With this in mind from an shmobile point of view I am happy for this code.
> >And there is no need to wait for a review from Magnus.
> 
> Has anyone merged this for upstream yet? If not, where should I send it?

I don't believe it has been merged.

My suggestion is to re-post it with my Ack with
Wolfram Sang <wsa@the-dreams.de> CCed.

Also, I think you need to provide documentation for the bindings in
Documentation/devicetree/bindings/i2c.
