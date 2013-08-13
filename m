From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Aug 2013 01:27:22 +0000
Subject: Re: EMEV2: I2C and SPI
Message-Id: <20130813012721.GD4885@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <5208C796.2050500@codethink.co.uk>
In-Reply-To: <5208C796.2050500@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 12, 2013 at 12:31:34PM +0100, Ian Molton wrote:
> Hi guys,
> 
> I've got SPI and I2C drivers for the emev2.
> 
> Right now, however they depend on Ben Dooks' clock patchset.
> 
> Are there plans to merge it, and when should I post my patches? Who
> is working on emev2 that might be worth CCing too?
> 
> I'd like to get these two drivers mainstreamed ASAP :)

Hi Ian,

I am currently on holidays and will be until the 21st. I apologise in
advance for my communication being sporadic during that time.

With regards to clocks, it should probably be reviewed by Magnus if it is
specific to emev2. However, I must confess that at this point I am unsure
which patchset you are referring to.

In general for drivers for Renesas hardware. My feeling is that they should
be reviewed by the relevant driver subsystem maintainer and CCed to the
shmobile mailing list.
