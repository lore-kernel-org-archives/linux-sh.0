From: Hideo Saito <saito@densan.co.jp>
Date: Thu, 06 Mar 2008 07:55:04 +0000
Subject: Re: TLB reset on SH7780
Message-Id: <20080306.165504.46638303.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080228.184540.68563408.saito@densan.co.jp>
In-Reply-To: <20080228.184540.68563408.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 6 Mar 2008 15:38:39 +0900, Paul Mundt wrote:
> Note that I'm also unable to reproduce this on SH7785. I assume this is
> only a problem if you have the PMB enabled?

Yes, the PMB is enabled.
I doesn't map all of the P1 area because there is no memory on the top of the P1 area, however, the driver for /dev/mem accesses from top of the P1 area, if I don't specify offset of the area. It causes TLB reset.
