From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 07:39:06 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a73a4: reorganise device instantiation in DT case
Message-Id: <Pine.LNX.4.64.1307050933170.28169@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372970438-21549-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 5 Jul 2013, Magnus Damm wrote:

> The answer to your question is probably yes, but more likely "that
> depends". See more below after 1-3.

Thanks for a detailed explanation. I shall save it somewhere for reference 
;-) One question though:

> - - -
> 
> We have 3 different DT_MACHINE definitions usually (2 per board and 1 for soc).
> 
> 1. DT_MACHINE in setup-xxx.c
> 
> This is supposed to be the long term DT support for a single SoC that
> we will use when we dump all other C board code and only rely on DT
> for board support. This will be used together with common clocks and
> multiplatform in the future. I don't want to have any platform
> devices, early timers or early printk or any non-standard bits here.
> Ideally all callbacks should be NULL here.
> 
> 2. MACHINE or DT_MACHINE in board-yyy.c
> 
> This is where complete C-only board support is located. This board
> support code may be back ported and used by people that want the
> latest driver support even though certain DT bindings may not be
> finalized yet. This is also a good place to do local non-upstream
> prototype hacking if you're into that sort of thing. The old legacy SH
> clock code is used here. Multiplatform will not be supported here. In
> some cases GIC and SMP can be initialized via DT for this code, but
> that will make back porting more difficult so it is not recommended
> for the majority of the platforms. This C only board support code
> should be replaced by the DT reference code described below, the
> sooner the better.
> 
> 3. DT_MACHINE in board-yyy-reference.c
> 
> This is the location for the DT board support used for incremental
> development. The hardware support feature set here is limited
> depending on how many drivers that have actual DT support. We want the
> code to be DT only here. In some special cases it is however
> acceptable to use platform devices (for instance serial consoles and
> timers that lack DT bindings and are needed for boot). If for instance
> clocks, pinctrl or gpio via DT aren't available for the particular SoC
> then board specific setup in C can be used as a stop-gap solution
> here. When common clocks become available this DT reference board
> support will be used together with multiplatform. When DT reference
> and C board code are on the same level and common clocks are available
> then only DT_MACHINE in setup-xxx.c will be used.
> 
> - - -
> 
> So regarding your question, it is OK for board code to add clock setup
> in C anywhere as long as common clocks are not yet implemented. As for
> adding platform devices, I don't want any of those in DT reference
> board code or DT_MACHINE in setup-xxx.c, but you can and should add
> those in the C version of the board code.

So, you mean, board-<board>-reference.c should not instantiate and 
devices? Then the call to r8a7790_add_dt_devices() in 
lager_add_standard_devices() in Simon's Lager reference patch is wrong? Or 
have I musunderstood?

Thanks
Guennadi

> If they are SoC specific and
> potentially shared across multiple boards then you can add them to
> setup-xxx.c but make sure that the DT_MACHINE stuff there isn't using
> any platform devices.
> 
> In the particular case of cpufreq, I expect a platform device to be
> added to board-yyy.c or since it is a per-SoC property it may be
> better to use setup-xxx.c. Please note that I don't want the
> DT_MACHINE bits in setup-xxx.c to make use of that platform device,
> instead a SoC specific function shall be used that can be called from
> the C board code. Also, in parallel with platform device in C board
> code you should add DT nodes for the DT reference board support.
> Exactly how to share the per-SoC DT reference DTSI bits is a different
> topic, but since we only have a single board for the majority of the
> SoCs it's sort of a minor issue code duplication wise.
> 
> Hope this clarifies.
> 
> Thanks,
> 
> / magnus
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
