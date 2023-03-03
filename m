Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24EFC678D4
	for <linux-sh@archiver.kernel.org>; Fri,  3 Mar 2023 07:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCCH0w (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 3 Mar 2023 02:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCCH0v (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 3 Mar 2023 02:26:51 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73F2FCC9
        for <linux-sh@vger.kernel.org>; Thu,  2 Mar 2023 23:26:49 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id d20so1561183vsf.11
        for <linux-sh@vger.kernel.org>; Thu, 02 Mar 2023 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677828409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bkonVyu22dNrP+5h2C16zbnZDdQn8bP2ZTSASRStT8g=;
        b=mpRWXhqvi4VkkxTClP8Wy6oFUQlPoMpf7tIQHmGd7Mca4jx9edOywT+CFBW9pbcoKw
         IA6a8+4a4atKqfjuqwU5vqVC/XUPkbRor/Gh6DkYGh/d0a2n3CYgdD/wGfOvqoNl4hP8
         3621zztDV0cRvd+mTuZW8UOyDh9LK6/GJ3KepYewJetpPvwqeU08cgLN6PJZiLFFYYm6
         vt8rmZrUGpVOvbTZMcha2wSZOjZ88ras1bxdS5NJX5c03AjgCNZQl4on6hxk+L7R8I0T
         hoVSeb6laRdoU+51y0cbS+iAflXIhUBPEyoF4gCYhU2pzykl39seceOPr0FQL1KwoZCz
         n9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677828409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkonVyu22dNrP+5h2C16zbnZDdQn8bP2ZTSASRStT8g=;
        b=HG7is9r0gf3BrBzszPrWjnMn9rv7oUgFjRYctz1+9mtuOXjX99PZJ74j5nOpkckLup
         drC3acOEsyIop16n9g655NO1yvpp/ttw1tXf2BJe7oTO/Wmc8/XL6bZyah60r/RVwJEB
         0OnvJIEIvbE7rOKL3sjw81Ry87/3qW0kSZ+ILtfCVu69mf0YRnA87sB9CQALBirmgAAh
         K2N7YgqUwvBWTVdK1gV/PeQZN4bDr0wsJKRZMpJ5Mi5UzAeTI3Vsmu0M2w53coufxNnv
         lgkiM6KiAhIsIQuEAnXFT7xBwHWDMaF4Z1olT5WT8MJN9wpmrZkv93JEKHG+uv77If3W
         7mcA==
X-Gm-Message-State: AO0yUKXv87S1XgaflND5eowZZODpVhdiZcB7HZ73BwFtOARiMlqoKZU4
        LugmCVjj7bchPcBB2BgLEYCPa8hjC9pCvET+ZZFQgQ==
X-Google-Smtp-Source: AK7set/dqhegsYsR1jgvCeZY2ASfYt9gTAF3iFtsa2f52nhtUhe4yfCtTCGf9LkkEb1igfPmcrmIfrracyBNo11YG8k=
X-Received: by 2002:a05:6102:2743:b0:412:25b3:10f3 with SMTP id
 p3-20020a056102274300b0041225b310f3mr546641vsu.7.1677828408700; Thu, 02 Mar
 2023 23:26:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677579750.git.geert+renesas@glider.be>
In-Reply-To: <cover.1677579750.git.geert+renesas@glider.be>
From:   David Gow <davidgow@google.com>
Date:   Fri, 3 Mar 2023 15:26:37 +0800
Message-ID: <CABVgOS=vXSuqrJ=6rbAZ1vT3Y=SR69T9EFikXKPY_hmv25riwQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] kunit: tool: Add support for SH under QEMU
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000050729905f5f9de4d"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

--00000000000050729905f5f9de4d
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Feb 2023 at 18:31, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series adds support to run tests via kunit_tool on the
> SuperH-based virtualized r2d platform.  As r2d uses the second serial
> port as the console, this needs a small modification of the core
> infrastructure.
>
> Thanks for your comments!

This series looks good to me, but I've not been able to successfully
get qemu to boot anything on SuperH (it just seems to hang with no
output).

Is there anything like magic config or firmware images (I didn't think
so for r2d: shix prints out an error, though) required to get this
going?

The qemu command KUnit is using seems correct (and none of the obvious
permutations, particularly around the serial ports seem to help):
qemu-system-sh4 -nodefaults -m 1024 -kernel .kunit/arch/sh/boot/zImage
-append 'kunit.enable=1 console=ttySC1 kunit_shutdown=reboot'
-no-reboot -nographic -serial null -machine r2d -serial mon:stdio

Cheers,
-- David

>
> Geert Uytterhoeven (2):
>   kunit: tool: Add support for overriding the QEMU serial port
>   kunit: tool: Add support for SH under QEMU
>
>  tools/testing/kunit/kunit_kernel.py    |  3 ++-
>  tools/testing/kunit/qemu_config.py     |  1 +
>  tools/testing/kunit/qemu_configs/sh.py | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/kunit/qemu_configs/sh.py
>
> --
> 2.34.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds

--00000000000050729905f5f9de4d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHHLXCbS0CYcocWQtL1
FY8wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzAxMjkw
NjQ2MThaFw0yMzA3MjgwNjQ2MThaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+31G8qfgjYj6KzASqulKfP5LGLw1o
hZ6j8Uv9o+fA+zL+2wOPYHLNIb6jyAS16+FwevgTr7d9QynTPBiCGE9Wb/i2ob9aBcupQVtBjlJZ
I6qUXdVBlo5zsORdNV7/XEqlpu+X5MK5gNHlWhe8gNpAhADSib2H4rjBvFF2yi9BHBAYZU95f0IN
cSS0WDNSSCktPaXtAGsI3tslroyjFYUluwGklmQms/tV8f/52zc7A5lzX+hxnnJdsRgirJRI9Sb6
Uypzk06KLxOO2Pg9SFn6MwbAO6LuInpokhxcULUz3g/CMQBmEMSEzPPnfDIAqwDI0Kqh0NAin+V4
fQxJfDCZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJyglaiY
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD2
/jVHvKzkc9h6mIts+GHlgh8v3+WmAffC0tZMA7jqWTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDMwNzI2NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArTfyNqbkyoyQFebdPpAN
qRFYrnVuC6v4CxTjkHGCTGfxb9Nt+7Lc/4DtiwxRa4k0sKBzhuvQIF2rOIEKu+Rk70Y620lYRgzP
lBHEK8sVhh1uag1sMc251FwPEa+xWoEZQzTOzpNN3nVoFkZQvF3ZS1P/he26YGOfeP5PviEVEVD9
JnJh6vUyPijyPm/e0MtGsUjb14TSLRlPJoQMUdBl7lb/R/IA6hvPcS9o7M/KV3e2K8SG3X1M2uCZ
qvvVDkXb1h5KapbqH/JzwX+8LRwoeZ4Skb1RWqtyQhq0C0OcwAueCeF0XZAAQmthJpFc/C4o20DT
WjlOEUP//aAtArDlPw==
--00000000000050729905f5f9de4d--
