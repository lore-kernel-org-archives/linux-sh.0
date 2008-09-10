From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 10 Sep 2008 07:44:14 +0000
Subject: Re: [PATCH] smc91x: SMC_IO_SHIFT platform data support for default case
Message-Id: <aec7e5c30809100044g1a51e7bfj240bdd67c5cb3012@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080908050234.11554.10123.sendpatchset@rx1.opensource.se>
	 <20080908111922.GA15553@verge.net.au>
In-Reply-To: <20080908111922.GA15553@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: netdev@vger.kernel.org, eric.miao@marvell.com, luca.santini@spesonline.com, nico@cam.org, linux-sh@vger.kernel.org

Hi Simon!

On Mon, Sep 8, 2008 at 8:19 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Sep 08, 2008 at 02:02:34PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Commit 159198862adad7109bb347bb30a620f67beac45f added SMC_IO_SHIFT
>> platform data support. After that ARM board support was added.
>>
>> The default case is still missing though, so on SuperH SMC_IO_SHIFT
>> is constantly zero regardless of what you pass as platform data.
>
> I beleive that its now common practice to include the subject
> of a commit along with its id, as the latter can change as
> it moves from tree to tree.

Oh, thanks for pointing that out. I should really do that next time.

In this case the commit id is from the linux-2.6 git, so shouldn't it
be stable enough? Isn't it the final destination? =)

Thanks!

/ magnus
