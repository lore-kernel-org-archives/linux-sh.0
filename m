From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Oct 2009 06:51:43 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <aec7e5c30910072351h152ebd3fuf531564af607eecb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Oct 8, 2009 at 1:45 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>
> Hi Magnus
>
> sorry for my late response

No worries, you are not late.

>> Can you give the attached patches a try?
>>
>> Apply in this order:
>> linux-2.6.32-rc-net-sh_eth-platform-data-mac-20091007b.patch
>> linux-2.6.32-rc-net-sh_eth-runtime-pm-20091007.patch
>> linux-2.6.32-rc-sh-ecovec-sh_eth-pdata-mac-20091007.patch
>> linux-2.6.32-rc-sh-ecovec-sh_eth-hwblk_id-20091007.patch
>>
>> They seem to work fine on ecovec for me. Do they solve your issue?
>
> How cool !!
> It works well on ecovec / ms7724se !!
> Thank you
>
> Tested-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Excellent, thanks for testing!

/ magnus
