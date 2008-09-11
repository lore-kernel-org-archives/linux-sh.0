From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Thu, 11 Sep 2008 14:29:25 +0000
Subject: Re: Question about framebuffer and kernel module
Message-Id: <48C92B45.6020202@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <600adaf50809110713y7c21b8b9l53b7b8798d1741e9@mail.gmail.com>
In-Reply-To: <600adaf50809110713y7c21b8b9l53b7b8798d1741e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Tiago Maluta wrote:
> Hi,
> 
> I'm work with frame buffer devices on ST reference boards using
> stmfb-3.0_stm23_0009 with kernel linux-2.6.17.14_stm22_0038.
> 
> After system boot I try to load stmcore-display-stx7100.ko
> 
> #modprobe stmcore-display-stx7100
> stmcore_display_stx7100: Unknown symbol request_firmware
> 
> Looking at /devkit/sources/stmfb/stmfb/Linux/stm/coredisplay/devfbOS.c
> I've commented the following lines and works.
> 
> --- a/devfbOS.c 2008-09-11 10:14:09.000000000 -0300
> +++ b/devfbOS.c 2008-09-11 10:15:05.000000000 -0300
> @@ -722,7 +722,8 @@
>      /* get linux firmware */
>      printk ("requesting frm: '%s', %p/%p\n",
>              name, &firmware_device, &lnx_firmware);
> -    error = request_firmware ((const struct firmware **)
> (&lnx_firmware), name, &firmware_device);
> +    //error = request_firmware ((const struct firmware **)
> (&lnx_firmware), name, &firmware_device);
> +    error=1;
>      if (unlikely (error))
>      {
>        kfree (fw);
> @@ -748,7 +749,7 @@
>      list_add_tail (&fw->fw_list, &fwd->fw_cache);
> 
>      /* release linux firmware */
> -    release_firmware (lnx_firmware);
> +    /* release_firmware (lnx_firmware); */
>    }
> 
> I know this fix work   because they didn't try to release firmware on module...
> But I didn't know why it really works and the implications doing what I do?
> 
> 
> Best regards,
> Tiago Maluta
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi Tiago,
please for STLinux related issue, use bugzilla channel at
https://bugzilla.stlinux.com/

Carmelo
