From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 26 Mar 2009 02:22:26 +0000
Subject: Re: [PATCH] sh: add kexec jump support V2
Message-Id: <49CAE6E2.1070409@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090318085129.5943.83795.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090318085129.5943.83795.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,all.

I'm sorry that I could not check this patch.

This patch became compilation error in SH2/SH2A, because there are
not a spc register and a ssr register in SH2.[0]
I don't have environment of SH2 and I don't know whether I work
by these measures.
Do you have somebody, environment?

[0]: http://kisskb.ellerman.id.au/kisskb/buildresult/271654/

Best regards,
 Nobuhiro

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add kexec jump support to the SuperH architecture V2.
> 
> Similar to the x86 implementation, with the following
> exceptions:
> 
> - Instead of separating the assembly code flow into
> two parts for regular kexec and kexec jump we use a
> single code path. In the assembly snippet regular
> kexec is just kexec jump that never comes back.
> 
> - Instead of using a swap page when moving data between
> pages the page copy assembly routine has been modified
> to exchange the data between the pages using registers.
> 
> - We walk the page list twice in machine_kexec() to
> do and undo physical to virtual address conversion.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>


