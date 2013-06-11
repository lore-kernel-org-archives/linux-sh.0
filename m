From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 11 Jun 2013 13:01:34 +0000
Subject: Re: [PATCH] sh_eth: get R8A7740 Rx descriptor word 0 shift out of #ifdef
Message-Id: <51B71FAE.6050005@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306110022.51293.sergei.shtylyov@cogentembedded.com> <51B6B702.6070005@renesas.com>
In-Reply-To: <51B6B702.6070005@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

On 11-06-2013 9:34, Shimoda, Yoshihiro wrote:

>> The only R8A7740 specific #ifdef hindering ARM multiplatform  build is left  in
>> sh_eth_rx(): it covers a very strange code shifting Rx buffer descriptor word 0
>> by 16 (which should cause Rx length error to be logged on every buffer  several
>> lines later). Get rid of the #ifdef by adding 'shift_rd0' field to the  'struct
>> sh_eth_cpu_data', making the shift dependent on it, and setting it to 1 for the
>> R8A7740 case...

> This very strange code was from the first R8A7740 supporting patch I sent.
> I should have shifted the RD_RFS values (from RD_RFS1 to RD_RFS10) if R8A7740.
> In other words, since the desc_status also has RDFEND, I should have not shifted
> the desc_status before the driver checked the RDFEND.

> So, I think we have to modify this "desc_status >>= 16" timing.
> Should I submit such a patch first?

    Yes, that would be preferable. Just give it a good description.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei

