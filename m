From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 31 Jan 2019 10:52:22 +0000
Subject: Re: [PATCH 4/7] sh_eth: offload RX checksum on R8A7740
Message-Id: <918892bc-4b2d-0235-cb51-749ca49bd4e8@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <e43f07fd-1407-a87a-7fe5-67a522da9e19@cogentembedded.com>
 <CAMuHMdUixqEcD36ReZj4noF5VOCNHS-qH_9herABkiLSVD3R8A@mail.gmail.com>
In-Reply-To: <CAMuHMdUixqEcD36ReZj4noF5VOCNHS-qH_9herABkiLSVD3R8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello!

On 01/29/2019 09:20 PM, Geert Uytterhoeven wrote:

>> The R-Mobile A1 (R8A7740) SoC manual describes the Ether MAC's RX checksum
>> offload the same way as it's implemented in the EtherAVB MAC...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your patch!
> 
> Running netperf as described in patch 2/7, perf tells me there's a reduction
> for csum_partial from ca. 1.9% to 0.01%, so this feature seems to work.

   Hm, what about do_csum()?

> Hence:
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

   Thank you!
 
> However, while effective according to perf results, using ethtool to
> enable/disable
> the feature prints an error message:
> 
> root@armadillo:~# ethtool -K eth0 rx on
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> root@armadillo:~# ethtool -K eth0 rx off
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> Cannot get device udp-fragmentation-offload settings: Operation not supported
> root@armadillo:~#
> 
> Do you have any clue?

   No (I'm seeing the same).
 
> Does this needs testing on R-Mobile A1 with VLAN enabled, too, or is that
> independent from the underlying sh-eth hardware version?

   It's dependent...

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergei
