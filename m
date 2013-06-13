From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 13 Jun 2013 00:57:40 +0000
Subject: Re: [PATCH net-next] net: sh_eth: fix incorrect RX length error if R8A7740
Message-Id: <51B91904.8070001@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51B7CFFB.7090801@renesas.com> <51B8CB1B.9020304@cogentembedded.com>
In-Reply-To: <51B8CB1B.9020304@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

Hi,

(2013/06/13 4:25), Sergei Shtylyov wrote:
> On 06/12/2013 05:33 AM, Shimoda, Yoshihiro wrote:
< snip >
>> +#if defined(CONFIG_ARCH_R8A7740)
>> +        /*
>> +         * In case of almost GETHER/ETHERs, the Receive Frame State
> 
>    Erm, minor nit: it seems you forgot "all" after "almost". Hence it's probably worth resubmitting...
> 

Thank you for the point. I will fix it and resubmit a patch for "net.git".

Best regards,
Yoshihiro Shimoda

>> +         * (RFS) bits in the Receive Descriptor 0 are from bit 9 to
>> +         * bit 0. However, in case of the R8A7740's GETHER, the RFS
>> +         * bits are from bit 25 to bit 16. So, the driver needs right
>> +         * shifting by 16.
>> +         */
>> +        desc_status >>= 16;
>> +#endif
>> +
> 
> WBR, Sergei
> 
> 
