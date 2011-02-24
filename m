From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 24 Feb 2011 08:35:57 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <4D66186D.8060207@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear Morimoto-san,

2011/02/24 17:16, Kuninori Morimoto wrote:
> 
> Dear Shimoda san
> 
>> -#ifdef CONFIG_CPU_SUBTYPE_SH7786
>> +#if defined(CONFIG_CPU_SUBTYPE_SH7757) || \
>> +    defined(CONFIG_CPU_SUBTYPE_SH7785)
> 
> Is this miss ?
> you remove 7786
> and add    7785 ?
Oh, Thank you very much! I mistook the code.
I must keep the 7786 and I would like to add 7757.
I will fix it.

Best regards,
Yoshihiro Shimoda

>               ~
> 
> Best regards
> --
> Kuninori Morimoto
>  
> 
