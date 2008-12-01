From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Mon, 01 Dec 2008 11:07:09 +0000
Subject: Re: [PATCH] sh: RSK+ 7201 board support
Message-Id: <4933C55D.8000303@mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <492EA011.40707@mpc-data.co.uk>
In-Reply-To: <492EA011.40707@mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, Nov 28, 2008 at 12:43:36PM +0000, Peter Griffin wrote:
>> Hi Paul,
>>
>> Paul Mundt wrote:
>>> On Thu, Nov 27, 2008 at 01:26:41PM +0000, Peter Griffin wrote:
>>>> From: Peter Griffin <pgriffin@mpc-data.co.uk>
>>>>
>>>> sh: RSK+ 7201 board support
>>>>
>>>> This patch adds support for the SH7201 processor subtype and RSK+ 7201 
>>>> board.
>>>>
>>>> Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
>>> Just a couple minor nits. I would prefer if you would send the CPU and
>>> the board support separately, so I don't have to try and split the patch
>>> up manually. Additionally, as far as new boards go, you should also
>>> provide a reasonable defconfig so that we can tie it in to the nightly
>>> builds and make sure no one ends up breaking it.
>> I've posted three more patches with the board and cpu stuff seperated out.
>> The third is a default kernel config. Is that ok?
>>
> Yes, that is fine. You missed a couple of places where the subtype and
> board type should be wired in, but I just added those by hand.
cheers
> 
> Also, your patches were heavily whitespace damaged, so it took a bit of
> wiggling to get them to even apply. Next time, please double check your
> mailer settings.
Ok, sorry about that. Its my first patch submission, but hopefully the
first of many (non damaged next time though!).
> 
> I have now applied all of the patches. Looking at the board support
> itself, it seems like the 7201 rsk and the 7203 rsk have a lot of
> similarities. I have not looked at the schematics or the datasheet for
> the board yet, so I am not aware of all of the differences between the
> two platforms, but the fact everything you have in board-rsk7201.c is
> identical to the rsk7203 (with the exception of ethernet and GPIOs being
> ripped out) suggests that this is something that should be rolled in to a
> mach-rsk in order to avoid needless duplication. This is something that
> can be done incrementally though, as the current implementation is
> sufficiently trivial.
Yes I agree, this is something which should be done.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

