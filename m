From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 11:44:44 +0000
Subject: Re: [PATCH] [V3] ARM: shmobile: r8a7790.dtsi: ficx i2c[0-3] clock reference
Message-Id: <52DD0C2C.5020700@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390218113-13715-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390218113-13715-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/01/14 11:44, Laurent Pinchart wrote:
> On Monday 20 January 2014 11:41:53 Ben Dooks wrote:
>> The R8A7790's dtsi file i2c0, i2c1, i2c2, and i2c3 nodes have clock
>> refrences to the mstp3_clks clock node, however these clocks are in the
>
> Nearly there, s/refrences/references/ :-)

I will go and die quietly in the corner...

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
