From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 05 Jun 2008 15:35:12 +0000
Subject: Re: Question on SH7763
Message-Id: <20080606003512.501d3025.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
In-Reply-To: <29ab51dc0806050432i51cb4a38tcedca20496d61131@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Thu, 5 Jun 2008 18:56:49 +0530 (IST)
pavan_savoy@indiatimes.com wrote:

> 
> Hi,
> 
> Thank you, I would also like to know, something about the development environment, If I want to write a new flash driver, or new ETH driver, and support them from u-boot, what best would be my environment ?
What does environment indicate?
Is it a compiler?Or, is it OS?

> 
> Because I would like to use a debugger (jtag/ICE) kind of a tool to debug symbols, put break points in u-boot, so is there anything like the GDB kind, for this ?
> 
U-Boot-sh doesn't support GDB now. And I don't use it.

If you want to use GDB, need suport.

Best regards,
 Nobuhiro

-- 
Nobuhiro Iwamatsu
