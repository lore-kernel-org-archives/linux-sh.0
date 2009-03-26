From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 26 Mar 2009 04:35:53 +0000
Subject: Re: [PATCH] sh: add kexec jump support V2
Message-Id: <20090326043553.GA31780@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090318085129.5943.83795.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090318085129.5943.83795.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 26, 2009 at 11:22:26AM +0900, Nobuhiro Iwamatsu wrote:
> Hi,all.
> 
> I'm sorry that I could not check this patch.
> 
> This patch became compilation error in SH2/SH2A, because there are
> not a spc register and a ssr register in SH2.[0]
> I don't have environment of SH2 and I don't know whether I work
> by these measures.
> Do you have somebody, environment?
> 
> [0]: http://kisskb.ellerman.id.au/kisskb/buildresult/271654/
> 
Kexec is not likely to work on nommu anyways, given that all of the tools
today assume ELF. I suspect we should just make it depend on MMU and be
done with it for now.
