From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Jan 2010 15:20:25 +0000
Subject: Re: USB boot problems submission
Message-Id: <20100125152024.GA2739@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B5D3019.9080900@renesas.com>
In-Reply-To: <4B5D3019.9080900@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 25, 2010 at 02:46:01PM +0900, Yusuke Goda wrote:
> Freeing unused kernel memory: 108k freed
> Kernel panic - not syncing: Attempted to kill init!
> Stack: (0x8f01de3c to 0x8f01e000)
> de20:                                                                8822dac8 
> de40: 881190d4 88266d44 8f01de68 88019256 8f0f4580 8f01fd60 8f01def0 8f01acc0 
> de60: 8f01acc0 882d22f0 8f01acb8 00000000 8f01de4c 00000004 00000001 00000000 
> de80: 8f01de80 8f01de80 88019840 000000fc 8f0f4580 8f01fd60 8f01def0 00000003 
> dea0: 00000004 8f01fd60 88022b8e 00000003 8f0f45c0 8f01dfa4 8f01df70 880050aa 
> dec0: 7b80fd18 8f01dfa4 29583004 00000008 88006464 880070ec 29583004 00000002 
> dee0: 8f01aef0 8f01acc0 8f104d40 8f104d74 00000004 00000000 00000080 00000000 
> df00: 00000000 00000000 00000000 00000000 8818ecd4 00000100 8818e700 8f11b4e0 
> df20: 88013e9a 8f01df30 8f11a8f8 00000001 000000f0 880212ca 00000000 00000000 
> df40: 8f01acc0 00000004 8f01af08 8f11a8f8 00000001 880213be 7b80fd18 00000001 
> df60: 00000004 8f0f4580 00000000 8f01acc0 00000003 00000000 88006484 00400034 
> df80: 8800648e 8800713c 7b80fd18 00400034 29583004 00000008 88006464 880070ec 
> dfa0: 8f01c000 00000078 00000000 004020c0 00008384 2956fca8 2956fca8 00000000 
> dfc0: 00000000 29583050 ffffff38 fffffe10 00000008 29583004 00400034 7b80fd18 
> dfe0: 7b80fd10 295609c0 2955863c 00008000 00000000 000000d8 0000006c ffffffff 
> 
> Call trace:
>  [<881190d4>] 0x881190d4
>  [<88019256>] 0x88019256
>  [<88019840>] 0x88019840
>  [<88022b8e>] 0x88022b8e
>  [<880050aa>] 0x880050aa
>  [<88006464>] 0x88006464
>  [<880070ec>] 0x880070ec
>  [<8818ecd4>] 0x8818ecd4
>  [<8818e700>] 0x8818e700
>  [<88013e9a>] 0x88013e9a
>  [<880212ca>] 0x880212ca
>  [<880213be>] 0x880213be
>  [<88006484>] 0x88006484
>  [<8800648e>] 0x8800648e
>  [<8800713c>] 0x8800713c
>  [<88006464>] 0x88006464
>  [<880070ec>] 0x880070ec
> 

You should rebuild your kernel with verbose BUG reporting and all of the
kallsyms bits turned on, which will give you a meaningful oops. That
should at least give us an idea of where things are going wrong,
otherwise we go back to bisecting.
